# Description:
#   Hubot plugin to get face detection data from AWS Rekognition
#
# Dependencies:
#   "aws-sdk": "^2.7.27"
#
# Configuration:
#  HUBOT_AWS_ACCESS_KEY_ID
#  HUBOT_AWS_SECRET_ACCESS_KEY
#
# Notes:
#   Attaches the following method to the robot object:
#   robot.rekognition.detectFaces <image Buffer> <callback>
#
# Author:
#   Neufeldtech https://github.com/neufeldtech

AWS = require('aws-sdk')
fs = require('fs')

rekognition = new (AWS.Rekognition)(
  region: 'us-west-2'
  accessKeyId: process.env.HUBOT_AWS_ACCESS_KEY_ID or 'foobar'
  secretAccessKey: process.env.HUBOT_AWS_SECRET_ACCESS_KEY or 'foobaz')


module.exports = (robot) ->
  class Rekognition
    detectFaces: (buffer, callback) ->
      params = 
        Image: 
          Bytes: buffer
      rekognition.detectFaces params, (err, res) ->
        if err
          robot.logger.error "Threw an error during rekognition face detection: #{JSON.stringify(err)}"
          return callback(err)
        robot.logger.debug "Got data response from rekognition: #{JSON.stringify(res)}"
        return callback(null, res)
  
  robot.rekognition = new Rekognition