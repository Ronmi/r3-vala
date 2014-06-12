[CCode (cheader_filename = "r3/r3.h")]
namespace R3 {

	[CCode (cname = "int", cprefix = "METHOD_", has_type_id = false)]
	[Flags]
	public enum Method {
		GET,
		POST,
		PUT,
		DELETE,
		PATCH,
		HEAD,
		OPTIONS
	}

	[CCode (cname = "route", free_function = "r3_route_free")]
	[Compact]
	public class Route<T> {
		[CCode (cname = "r3_route_create")]
		public Route (string path);

		[CCode (cname = "path")]
		private string _path;

		[CCode (cname = "path_len")]
		private int _path_len;

		public string path {
			set { _path = path; _path_len = path.length; }
			get { return _path; }
		}

		[CCode (cname = "request_method")]
		public Method request_method;

		[CCode (cname = "host")]
		private string _host;

		[CCode (cname = "host_len")]
		private int _host_len;

		public string host {
			set { _host = host; _host_len = host.length; }
			get { return _host; }
		}
		
		[CCode (cname = "remote_addr_pattern")]
		private string _remote_addr_pattern;

		[CCode (cname = "remote_addr_pattern_len")]
		private int _remote_addr_pattern_len;

		public string remote_addr_pattern {
			set {
				_remote_addr_pattern = remote_addr_pattern;
				_remote_addr_pattern_len = remote_addr_pattern.length;
			}
			get { return _remote_addr_pattern; }
		}

		[CCode (cname = "data")]
		public unowned T data;
	}

	[CCode (cname = "str_array", free_function = "str_array_free", cheader_filename = "r3/str_array.h", cprefix = "r3_strarr")]
	[Compact]
	public class StrArray {
		[CCode (cname = "tokens", array_length_cname = "len")]
		public string[] tokens { get; }

		[CCode (cname = "cap")]
		public int capacity { get; }

		[CCode (cname = "str_array_resize")]
		public bool resize (int new_cap);


		[CCode (cname = "str_array_create")]
		public StrArray (int cap);

		[CCode (cname = "split_route_pattern")]
		private StrArray._from_pattern (string pattern, int pattern_len);
		public  StrArray.from_pattern (string pattern) {
			this._from_pattern (pattern, pattern.length);
		}

		[CCode (cname = "str_array_is_full")]
		public bool is_full ();

		[CCode (cname = "str_array_append")]
		public bool append (string token);

		[CCode (cname = "str_array_dump")]
		public void dump ();
	}

	[CCode (cname = "match_entry", free_function = "match_entry_free")]
	[Compact]
	public class Match<T> {
		
		[CCode (cname = "match_entry_create")]
		public Match (string path);
		
		[CCode (cname = "vars")]
		public unowned StrArray vars;

		[CCode (cname = "path")]
		private string _path;

		[CCode (cname = "path_len")]
		private int _path_len;

		public string path {
			set { _path = path; _path_len = path.length; }
			get { return _path; }
		}
		
		[CCode (cname = "host")]
		private string _host;

		[CCode (cname = "host_len")]
		private int _host_len;

		public string host {
			set { _host = host; _host_len = host.length; }
			get { return _host; }
		}
		
		[CCode (cname = "remote_addr_pattern")]
		private string _remote_addr_pattern;

		[CCode (cname = "remote_addr_pattern_len")]
		private int _remote_addr_pattern_len;

		public string remote_addr_pattern {
			set {
				_remote_addr_pattern = remote_addr_pattern;
				_remote_addr_pattern_len = remote_addr_pattern.length;
			}
			get { return _remote_addr_pattern; }
		}

		[CCode (cname = "data")]
		public unowned T data;
	}

	[CCode (cname = "edge", free_function = "r3_edge_free", cprefix = "r3_edges")]
	[Compact]
	public class Edge {
		[CCode (cname = "r3_edge_createl")]
		private Edge.real (string pattern, int pattern_len, Node child);
		public  Edge      (string pattern, Node child) {
			this.real (pattern, pattern.length, child);
		}
		
		[CCode (cname = "r3_edge_branch")]
		public unowned Node branch (int dl);
	}

	[CCode (cname = "node", free_function = "r3_tree_free", cprefix = "r3_nodes")]
	[Compact]
	public class Node<T> {
		[CCode (cname = "data")]
		public unowned T? data;

		[CCode (cname = "r3_node_create")]
		public Node ();
		
		[CCode (cname = "r3_tree_create")]
		public Node.with_capacity (int cap);

		[CCode (cname = "r3_tree_dump")]
		public void dump (int depth);

		[CCode (cname = "r3_node_connectl")]
		private unowned Edge _connectl (string pat, int len, bool strdup, Node child);
		public  unowned Edge  connectl (string pat, bool strdup, Node child) {
			return this._connectl (pat, pat.length, strdup, child);
		}

		[CCode (cname = "r3_node_connect")]
		public unowned Edge connect (string pat, Node child);

		/**
		 * According to node.c:144, the return value might be NULL
		 */
		[CCode (cname = "r3_node_find_edge")]
		private unowned Edge? _find_edge (string pat, int len);
		public  unowned Edge?  find_edge (string pat) {
			return this._find_edge (pat, pat.length);
		}

		[CCode (cname = "r3_node_append_edge")]
		public void append_edge (Edge child);

		/**
		 * According to node.c:572, the return value might be NULL
		 */
		[CCode (cname = "r3_node_find_common_prefix")]
		private unowned Edge? _find_common_prefix (string path, int path_len, out int prefix_len, out string errstr);
		public  unowned Edge?  find_common_prefix (string path, out int prefix_len, out string errstr) {
			return this._find_common_prefix (path, path.length, out prefix_len, out errstr);
		}

		/**
		 * According to node.c:605, the return value might be NULL
		 */
		[CCode (cname = "r3_tree_insert_path")]
		public unowned Node? insert_path (string path, T? data);

		/**
		 * According to node.c:509, the return value might be NULL
		 */
		[CCode (cname = "r3_tree_insert_route")]
		public unowned Route? insert_route (Method method, string path, T? data);

		[CCode (cname = "r3_tree_compile")]
		public int compile (out string? errstr);

		[CCode (cname = "r3_tree_match")]
		private unowned Node? _match (string path, Match? entry);
		public  unowned Node? match (string path) {
			return this._match (path, null);
		}

		[CCode (cname = "r3_tree_match_entry")]
		public unowned Node? match_entry (Match entry);

		[CCode (cname = "r3_node_has_slug_edges")]
		public unowned bool has_slug_edges();
	}
}