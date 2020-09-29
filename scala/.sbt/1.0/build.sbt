commands += Command.command("clear") { state => print("\033c"); state }

// def flaky = Command("flaky")(parser) {(state,args) =>
//  val taskKey = Keys.test in Test
//  for (i <- (1 to 5)) {
//    println(s"Running tests: $i")
//    Project.runTask(taskKey, state)
//  }
// }
