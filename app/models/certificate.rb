require 'openssl'

class Certificate < ActiveRecord::Base
  validates_presence_of :cert_hash

  attr_accessor :certificate_file

  def self.default_certificate
    where(default: true).first
  end

  after_save do |certificate|
    if(certificate.default?)
      Certificate.where.not(id: certificate.id).update_all(:default => false)
    end
  end

  before_validation do
    #binding.pry
    logger.debug self.certificate_file.inspect
    if self.certificate_file
      begin
        cert = OpenSSL::X509::Certificate.new(self.certificate_file.read)
        self.subject = cert.subject.to_s
        self.issuer = cert.issuer.to_s
        self.valid_until = cert.not_after
        self.cert_hash = OpenSSL::Digest::SHA256.hexdigest(cert.to_der).to_s
        extensions = cert.extensions
        subject_alt_names = ""
        if extensions
          extensions.each do |ext|
            if ext.to_s.start_with? ('subjectAltName')
              subject_alt_names = ext.to_s.sub('subjectAltName','').delete('=').strip
            end
          end
        end
        self.subject_alt_names = subject_alt_names
      rescue => e
        self.errors.add(:certificate_file, "Parsing error: " + e.to_s )
      end

    end
  end

end
