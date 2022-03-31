data "http" "akiya" {
  url = "https://github.com/akiya64.keys"
}

resource "sakuracloud_ssh_key" "akiya" {
  name = "akiya"
  public_key = data.http.akiya.body
}
