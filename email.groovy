import javax.mail.*
import javax.mail.internet.*
import javax.activation.*
import groovy.json.JsonOutput

def readCredentials(String filePath) {
    def file = new File(filePath)
    if (!file.exists()) {
        throw new FileNotFoundException("Credentials file not found: ${filePath}")
    }
    def lines = file.readLines()
    if (lines.size() < 2) {
        throw new IllegalArgumentException("Invalid credentials file format. Expected two lines with username and password.")
    }
    return [lines[0], lines[1]]
}

def sendEmail(String buildDir, String stageDir, String platformName) {
    def smtpServer = 'smtp.siemens.com'
    def smtpPort = 587
    def username, password
	(username, password) = readCredentials('/plm/pnnas/jtdev/yyjtadmn_only/credentials.txt')
    

    def CPNum = params.CPNumber ?: "NA"
    def subject = "Job Executed"
    def details = """
        Hi team; <br>
        Please see details of latest build as below: <br><br>
        
        
        <br><br>
        Regards; <br>
        YYTWINT
    """

    Properties props = new Properties()
    props.put("mail.smtp.auth", "true")
    props.put("mail.smtp.starttls.enable", "true")
    props.put("mail.smtp.host", smtpServer)
    props.put("mail.smtp.port", smtpPort.toString())

    Session session = Session.getInstance(props, new javax.mail.Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, password)
        }
    })

    try {
        MimeMessage msg = new MimeMessage(session)
        msg.setFrom(new InternetAddress('yytwint.sisw@siemens.com'))
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse('roma.mohapatra@siemens.com'))
        msg.setSubject(subject)
        msg.setContent(details, "text/html; charset=utf-8")

        Transport.send(msg)
        println('Email sent successfully.')
    } catch (AuthenticationFailedException e) {
        println('Failed to authenticate with the SMTP server. Check your username and password.')
    } catch (MessagingException e) {
        println("Failed to send email: ${e.message}")
    }
}

return this
