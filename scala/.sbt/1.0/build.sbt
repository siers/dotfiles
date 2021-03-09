// https://stackoverflow.com/questions/40741244/how-to-execute-a-command-in-task

/**
  * Convert the given command string to a release step action, preserving and      invoking remaining commands
  * Note: This was copied from https://github.com/sbt/sbt-release/blob/663cfd426361484228a21a1244b2e6b0f7656bdf/src/main/scala/ReleasePlugin.scala#L99-L115
  */
def runCommandAndRemaining(command: String): State => State = { st: State =>
  import sbt.complete.Parser
  @annotation.tailrec
  def runCommand(command: String, state: State): State = {
    val nextState = Parser.parse(command, state.combinedParser) match {
      case Right(cmd) => cmd()
      case Left(msg) => throw sys.error(s"Invalid programmatic input:\n$msg")
    }
    nextState.remainingCommands.toList match {
      case Nil => nextState
      case head :: tail => runCommand(head.commandLine, nextState.copy(remainingCommands = tail))
    }
  }
  runCommand(command, st.copy(remainingCommands = Nil)).copy(remainingCommands = st.remainingCommands)
}

commands += Command.command("clear") { state => print("\033c"); state }
commands += Command.args("t", "<file>") { (state, args) => runCommandAndRemaining(s"~clear; test:testOnly *${args(0)}")(state) }

// def flaky = Command("flaky")(parser) {(state,args) =>
//  val taskKey = Keys.test in Test
//  for (i <- (1 to 5)) {
//    println(s"Running tests: $i")
//    Project.runTask(taskKey, state)
//  }
// }
