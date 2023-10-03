# calculate total used memory

$1 == "MemTotal:" {
  total = $2;
}

$1 == "MemAvailable:" {
  available = $2;
  used = (total - available) / total * 100;
  printf("%.0f%", used);
}
