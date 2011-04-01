var graph = new Graph();

var node = {};
$.get('graph.json', function(data) {
  // go through once to create all the nodes
  for (var i in data) {
    node[data[i].id] = graph.newNode({label: data[i].title || data[i].name});
  }
  // go through again to connect edges
  for (var i in data) {
    var n = data[i];
    for (var j in n.deps) {
      graph.newEdge(node[n.deps[j]], node[n.id], {color: 'green'});
    }
  }

  // render
  $('#graph').springy({graph:graph});
});
