{
  fetchFromGitHub,
  python3,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "shell-gpt";
  version = "1.4.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "TheR1D";
    repo = "shell_gpt";
    tag = version;
    hash = "sha256-4/5CLzIq+RXVTJk4chrd65GeazRp8VFKdOMt3fT+mbI=";
  };

  pythonRelaxDeps = [
    "requests"
    "rich"
    "distro"
    "typer"
    "instructor"
  ];

  build-system = with python3.pkgs; [hatchling];

  propagatedBuildInputs = with python3.pkgs; [
    click
    distro
    instructor
    litellm
    rich
    typer
  ];

  # Tests want to read the OpenAI API key from stdin
  doCheck = false;
}