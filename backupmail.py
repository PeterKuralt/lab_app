#!/usr/bin/bash

import smtplib

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders

fromaddr="pilabapp@gmail.com"
toaddr="pilabapp@gmail.com"

msg=MIMEMultipart()
msg['FROM']=fromaddr
msg['TO']=toaddr
msg['Subject']="Database backup for DnevnaSoba"
body='You can find the backup of Dnevna soba lab_app in attachment'
msg.attach(MIMEText(body,'plain'))

filename=("lab_app.db")
attachment=open("/var/www/lab_app/lab_app.db","rb")

part = MIMEBase('application', 'octet-stream')
part.set_payload((attachment).read())
encoders.encode_base64(part)
part.add_header('Content-Disposition',"attachment;filename=%s"%filename)
msg.attach(part)

server = smtplib.SMTP('smtp.gmail.com',587)
server.ehlo
server.starttls()
server.login(fromaddr, "11pibaye")
text=msg.as_string()
server.sendmail(fromaddr,toaddr,text)
server.quit
