BEGIN {
  split(source, criterias, " ");
}
END {
  for (i in criterias) {
    printf "%s => %s\n", i, criterias[i]
  }
}
