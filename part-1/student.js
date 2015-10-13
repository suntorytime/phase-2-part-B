var Student = function(firstName, scores) {
  this.firstName = firstName;
  this.scores = scores;
  var total = 0;
  this.averageScore = function() {
    for(var i = 0; i < scores.length; i++) {
      total += scores[i];
    }
    var avg = total / scores.length;
    total = Math.floor(avg);
    return total
  };
  var grade = "";
  this.letterGrade = function() {
    if (this.averageScore() >= 90) {
      grade = "A";
    }
    else if (this.averageScore() >= 80) {
      grade = "B";
    }
    else if (this.averageScore() >= 70) {
      grade = "C";
    }
    else if (this.averageScore() >= 60) {
      grade = "D";
    }
    else {
      grade = "F";
    }
    return grade
  }
}
