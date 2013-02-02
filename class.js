


function Apple (type) {
    this.type = type;
    this.color = "red";
}

Apple.prototype.getInfo = function() {
    return this.color + ' ' + this.type + ' apple';
};

Apple.prototype.blue = function() {
    return this.color = "blue";
};

Apple.prototype.getInfo2 = function() {
    return this.getInfo();
};


function w(s)
{
    console.log(s);
}
function testApple()
{
  var a = new Apple("Fuji");
  a.style = 'bold';
  a['style'] = 'italic';
  // a.blue();
  a.getInfo2();
  w('appple=' + a.getInfo());
  w('style=' + a.style);
}


testApple();



 
 
