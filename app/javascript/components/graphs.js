// t_data =
new Morris.Bar({
  // // ID of the element in which to draw the chart.
  element: 'amount_per_user',
  // // Chart data records -- each entry in this array corresponds to a point on
  // // the chart.
  // data: [
  //   { "zone": 'Zona 1', "amount": 4000},
  //   { "zone": 'Zona 2', "amount": 4000},
  //   { "zone": 'Zona 3', "amount": 0}
  //   ],
  data: document.querySelector('#amount_per_user').dataset.tickets,
  // // The name of the data record attribute that contains x-values.
  // label: 'zone',
  // value: 'amount',
  // // A list of names of data record attributes that contain y-values.
  // // ykeys: ['value'],
  // // Labels for the ykeys -- will be displayed when you hover over the
  // // chart.
  // labels: ['PZ'],
  // element: 'amount_per_user',
  // data: [
  //   { y: '2006', a: 100, b: 90 },
  //   { y: '2007', a: 75,  b: 65 },
  //   { y: '2008', a: 50,  b: 40 },
  //   { y: '2009', a: 75,  b: 65 },
  //   { y: '2010', a: 50,  b: 40 },
  //   { y: '2011', a: 75,  b: 65 },
  //   { y: '2012', a: 100, b: 90 }
  // ],
  xkey: 'zone',
  ykeys: ['amount'],
  labels: ['Series A', 'Series B']
});
// });
