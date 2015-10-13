var Classroom = function(students) {
  this.students = students;
  this.find = function(name) {
    for (i = 0; i < students.length; i++) {
      if (students[i].firstName == name) {
        return students[i];
      }
    }
  };
  var honor = []
  this.honorRollStudents = function() {
    for (i=0; i < students.length; i++) {
      if (students[i].averageScore() >= 95) {
        honor.push(students[i]);
      }
    }
    return honor
  }
}
