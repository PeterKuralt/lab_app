#!/usr/bin/bash

import smtplib

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders

#email you are sending from
fromaddr="yourmail@gmail.com"
#email you are sending to
toaddr="youremail@gmail.com"

msg=MIMEMultipart()
msg['FROM']=fromaddr
msg['TO']=toaddr
msg['Subject']="Here goes your subject"
body='Here goes your body text'
msg.attach(MIMEText(body,'plain'))

#filename of your database
filename=("lab_app.db")
#path to your attachment
attachment=open("/var/www/lab_app/lab_app.db","rb")

part = MIMEBase('application', 'octet-stream')
part.set_payload((attachment).read())
encoders.encode_base64(part)
part.add_header('Content-Disposition',"attachment;filename=%s"%filename)
msg.attach(part)

server = smtplib.SMTP('smtp.gmail.com',587)
server.ehlo
server.starttls()
server.login(fromaddr, "youremailpassword")
text=msg.as_string()
server.sendmail(fromaddr,toaddr,text)
server.quit
