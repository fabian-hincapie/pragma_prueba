resource "aws_sns_topic" "monitoreo" {
  name = "monitoreo_pragma"
}

resource "aws_sns_topic_subscription" "monitoreo" {
  topic_arn = aws_sns_topic.monitoreo.arn
  protocol  = "email"
  endpoint  = "fabian.andres.h.h@gmail.com"
}