var a=['apple','bull','drink'];

Array.prototype.removeByStr = function () {
  var what, a = arguments, L = a.length, ax;
  while (L && this.length) {
    what = a[--L];
    while ((ax = this.indexOf(what)) != -1) {
      this.splice(ax, 1);
    }
  }
  return this;
}


if(!Array.prototype.indexOf2){
    Array.prototype.indexOf2= function(what, i){
        i= i || 0;
        var L= this.length;
        while(i< L){
            if(this[i]=== what) return i;
            ++i;
        }
        return -1;
    }
}

a=[];

if(idx=a.indexOf2('bull') != -1)
{
a.splice(idx,1);
}





var str=a.join(',');

console.log('str=' + str);

 var result = !!String("false"); 
console.log('result=' + result);

