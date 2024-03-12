resource "aws_sns_topic" "notification_topic" {
  name = var.notification_topic_name
}
