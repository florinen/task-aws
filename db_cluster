resource "aws_rds_cluster" "db_dev" {
  cluster_identifier = "aurora-cluster_1"
  availability_zones = ["${aws_subnet.priv_1_subnet_eu_west_1a}", "${aws_subnet.priv_2_subnet_eu_west_1b}"]
  database_name      = "my_nc_db"
  master_username    = "nc_user"
  master_password    = ""
}