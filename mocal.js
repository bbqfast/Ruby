function mcDay () {
  this.text = '';
  this.enabled = true;
}

function mcCalendar () {
    this.backEnabled = true;
    this.forwardEnabled = true;
    this.today = new Date();
    this.selectedMonthOffset = 0;
    this.monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    
    this.grid = new Array(7*6);
    for(var i = 0;i < this.grid.length; i++)
    {
      this.grid[i] = new mcDay();
    }
    
    this.updateGrid();
}

mcCalendar.prototype.fillCalendar = function(dayOfWeekMonthBegin, daysInMonth ,cal)
{
  w('fillCalendar:' + dayOfWeekMonthBegin+ ' ' + daysInMonth);
  var dayOfMonth = 1;
  for (var i=0; i < cal.length; i++)
  {
    if (i >= dayOfWeekMonthBegin&& dayOfMonth < daysInMonth)
    {
      cal[i].text = dayOfMonth.toString();
      dayOfMonth++;

    }
    else
    {
      cal[i].text = '';
    }
  }
}

mcCalendar.prototype.daysInMonth = function(dateObj) {
    
    return new Date(dateObj.getFullYear(), dateObj.getMonth(), 0).getDate();
}

mcCalendar.prototype.firstOfMonth = function (dateobj)
{
  dateobj.setDate(1);
  return dateobj.getDay() % 7;
}

mcCalendar.prototype.dumpCalendar = function()
{
  w("Month=" + this.monthNames[this.selectedDateObj().getMonth()] );
  var buf="";
  for (var i=0;i < this.grid.length;i++)
  {
    var dayLabel;
    if ( !this.grid[i].text.length)
    {
      dayLabel = padStr(2,  " ");
    }
    else
    {
      dayLabel = padStr(2, this.grid[i].text);
    }
    
    if ((i % 7) == 0)
    {
      w(buf);
      buf = "";
    }
    
    buf = buf + "[" + dayLabel + "]";
  }
  w(buf);
}

mcCalendar.prototype.addMonth = function(dateObj, month)
{
  var date = new Date();
  var copiedDate = new Date(date.getTime());  
  copiedDate.setMonth(copiedDate.getMonth() + month);
  return copiedDate;
}

mcCalendar.prototype.selectedDateObj = function()
{
  return this.addMonth(this.today,this.selectedMonthOffset);
}

mcCalendar.prototype.updateGrid = function()
{
  var selectedMonth = this.selectedDateObj();
  this.fillCalendar(this.firstOfMonth(selectedMonth), this.daysInMonth(selectedMonth), this.grid);
}

mcCalendar.prototype.moveMonth = function(byNumOfMonth)
{
  this.selectedMonthOffset = this.selectedMonthOffset + byNumOfMonth;
  this.updateGrid();
}

// build 2 dimensional grid
function currDate()
{
  var today = new Date();
  today.setDate(6);
  w('month=' + today.getMonth());
  w('year=' + today.getFullYear());
  w('day of month ' + today.getDay());
  w(today);
}

function padStr(len, str)
{
  var diff = len - str.length;
  return Array(diff + 1).join(' ') + str;
}

function firstOfMonth(dateobj)
{
  dateobj.setDate(1);
  return dateobj.getDay();
}

function daysInMonth(month,year) {
    return new Date(year, month, 0).getDate();
}

function testDaysInMonth(year)
{
  w(daysInMonth(1,year));
  w(daysInMonth(2,year));
  w(daysInMonth(3,year));
}

function dumpCalendar(cal)
{
  var buf="";
  for (var i=0;i < cal.length;i++)
  {
    var dayLabel;
    if ( (typeof cal[i] == 'undefined') || !cal[i].length)
    {
      dayLabel = padStr(2,  " ");
    }
    else
    {
      dayLabel = padStr(2, cal[i]);
    }
    
    if ((i % 7) == 0)
    {
      w(buf);
      buf = "";
    }
    
    buf = buf + "[" + dayLabel + "]";
  }
  w(buf);
}

function fillCalendar(dayOfWeekMonthBegin,days ,cal)
{
  w('fillCalendar:' + dayOfWeekMonthBegin+ ' ' + days);
  var dayOfMonth = 1;
  for (var i=0; i < 7*5; i++)
  {
    if (i >= dayOfWeekMonthBegin && dayOfMonth < days)
    {
      cal[i] = dayOfMonth.toString();
      dayOfMonth++;

    }
    else
    {
      cal[i] = undefined;
    }
  }
}

function fillCalendar0(dayOfWeekMonthBegin,days ,cal)
{
  w('fillCalendar:' + dayOfWeekMonthBegin+ ' ' + days);
  var start = dayInWeek;
  var dayOfMonth = 1;
  for (var i=start; i < days; i++)
  {
    //w('x');
    cal[i] = dayOfMonth.toString();
    dayOfMonth++;
  }
}

function subtractMonth(dateObj, month)
{
  var date = new Date();
  var copiedDate = new Date(date.getTime());  
  copiedDate.setMonth(copiedDate.getMonth() + month);
  return copiedDate;
}

function w(str)
{
  console.log(str);
}

var today = new Date();

w(today);
w(firstOfMonth(today));
w(today);
w(testDaysInMonth(2012));
var gcal = new Array(7*5);
fillCalendar(firstOfMonth(subtractMonth(today, -1)), daysInMonth(1,2012), gcal);
dumpCalendar(gcal);
fillCalendar(firstOfMonth(today), daysInMonth(1,2012), gcal);
dumpCalendar(gcal);
fillCalendar(firstOfMonth(subtractMonth(today, 1)), daysInMonth(1,2012), gcal);
dumpCalendar(gcal);
w('----------------------------');

var cc = new mcCalendar();
// cc.fillCalendar(firstOfMonth(subtractMonth(today, 1)), daysInMonth(1,2012), cc.grid);
//cc.init();
cc.moveMonth(-6);
cc.dumpCalendar();
cc.moveMonth(1);
cc.dumpCalendar();
cc.moveMonth(1);
cc.dumpCalendar();
