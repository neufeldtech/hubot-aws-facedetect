AWS = require('aws-sdk')
fs = require('fs')

rekognition = new (AWS.Rekognition)(
  region: 'us-west-2'
  accessKeyId: process.env.HUBOT_AWS_ACCESS_KEY_ID or 'foobar'
  secretAccessKey: process.env.HUBOT_AWS_SECRET_ACCESS_KEY or 'foobaz')

face = fs.readFileSync('/home/jordan/Pictures/milton/derek.jpg')

params = 
  Image: 
    Bytes: face

rekognition.detectFaces params, (err, res) ->
  if err
    console.log err
  else
    console.log JSON.stringify(res)
  return
