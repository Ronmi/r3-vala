using R3;

void test () {
	R3.Node<int> n = new R3.Node<int>.with_capacity (10);

	int route_data = 3;
	n.insert_path ("/bar", route_data);
	n.insert_path ("/zoo", route_data);
	n.insert_path ("/foo/bar", route_data);
	n.insert_path ("/post/{id}", route_data);
	n.insert_path ("/user/{id:\\d+}", route_data);

	// routing with conditions
	n.insert_route (Method.GET | Method.POST, "/blog/post", route_data);

	string errstr;
	int err = n.compile (out errstr);
	if (err != 0) {
		stderr.printf ("error: %s\n", errstr);
	}

	n.dump (0);

	unowned R3.Node<int> tmp = n.match ("/foo/bar");
	int data = tmp.data;
	stdout.printf ("route data: %d", data);


	// capture dynamic variables
	Match<int> match = new Match<int> ("/user/123");
	tmp = n.match_entry (match);
	// dump catched vars
	match.vars.dump ();
	stdout.printf ("match data: %d", match.data);


}

void main (string[] args) {
	test ();
}