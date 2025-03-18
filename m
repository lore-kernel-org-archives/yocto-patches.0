Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A2C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 15:16:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.489.1742310998693912047
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Mar 2025 08:16:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 638F413D5
	for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 08:16:46 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8445B3F694
	for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 08:16:37 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] scripts/dashboard/bugtriage: make the bug tables sortable
Date: Tue, 18 Mar 2025 15:16:31 +0000
Message-ID: <20250318151633.3248395-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 15:16:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1216

Very useful for eg Old Milstone where you can then sort it by owner.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html   |   9 +-
 scripts/dashboard/bugtriage/sorttable.js | 495 +++++++++++++++++++++++
 2 files changed, 503 insertions(+), 1 deletion(-)
 create mode 100755 scripts/dashboard/bugtriage/sorttable.js

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 161df2a5..fef32f95 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -23,6 +23,10 @@
     .table-of-contents a.active {
       border-left-color: #03a9f4;
     }
+
+    table.sortable th:not(.sorttable_sorted):not(.sorttable_sorted_rever=
se):not(.sorttable_nosort):after {
+      content: " \25B4\25BE"
+    }
   </style>
 </head>
=20
@@ -157,6 +161,7 @@
     </div>
   </div>
   </div>
+  <script src=3D"sorttable.js"></script>
   <script>
     const serverUrl =3D "https://bugzilla.yoctoproject.org";
=20
@@ -187,7 +192,7 @@
       }
=20
       const table =3D document.createElement("table");
-      table.setAttribute("class", "highlight")
+      table.setAttribute("class", "highlight sortable")
=20
       const header =3D table.appendChild(document.createElement("thead")=
);
       const tr =3D header.appendChild(document.createElement("tr"));
@@ -210,6 +215,8 @@
       const footer =3D table.appendChild(document.createElement("tfoot")=
);
       footer.innerHTML =3D `<tr><td colspan=3D"${fields.size}">${bugs.le=
ngth} bugs found.</td></tr>`;
=20
+      sorttable.makeSortable(table);
+
       document.querySelector(selector).replaceChildren(table);
     }
=20
diff --git a/scripts/dashboard/bugtriage/sorttable.js b/scripts/dashboard=
/bugtriage/sorttable.js
new file mode 100755
index 00000000..48a40317
--- /dev/null
+++ b/scripts/dashboard/bugtriage/sorttable.js
@@ -0,0 +1,495 @@
+/*
+  SortTable
+  version 2
+  7th April 2007
+  Stuart Langridge, http://www.kryogenix.org/code/browser/sorttable/
+
+  Instructions:
+  Download this file
+  Add <script src=3D"sorttable.js"></script> to your HTML
+  Add class=3D"sortable" to any table you'd like to make sortable
+  Click on the headers to sort
+
+  Thanks to many, many people for contributions and suggestions.
+  Licenced as X11: http://www.kryogenix.org/code/browser/licence.html
+  This basically means: do what you want with it.
+*/
+
+
+var stIsIE =3D /*@cc_on!@*/false;
+
+sorttable =3D {
+  init: function() {
+    // quit if this function has already been called
+    if (arguments.callee.done) return;
+    // flag this function so we don't do the same thing twice
+    arguments.callee.done =3D true;
+    // kill the timer
+    if (_timer) clearInterval(_timer);
+
+    if (!document.createElement || !document.getElementsByTagName) retur=
n;
+
+    sorttable.DATE_RE =3D /^(\d\d?)[\/\.-](\d\d?)[\/\.-]((\d\d)?\d\d)$/;
+
+    forEach(document.getElementsByTagName('table'), function(table) {
+      if (table.className.search(/\bsortable\b/) !=3D -1) {
+        sorttable.makeSortable(table);
+      }
+    });
+
+  },
+
+  makeSortable: function(table) {
+    if (table.getElementsByTagName('thead').length =3D=3D 0) {
+      // table doesn't have a tHead. Since it should have, create one an=
d
+      // put the first table row in it.
+      the =3D document.createElement('thead');
+      the.appendChild(table.rows[0]);
+      table.insertBefore(the,table.firstChild);
+    }
+    // Safari doesn't support table.tHead, sigh
+    if (table.tHead =3D=3D null) table.tHead =3D table.getElementsByTagN=
ame('thead')[0];
+
+    if (table.tHead.rows.length !=3D 1) return; // can't cope with two h=
eader rows
+
+    // Sorttable v1 put rows with a class of "sortbottom" at the bottom =
(as
+    // "total" rows, for example). This is B&R, since what you're suppos=
ed
+    // to do is put them in a tfoot. So, if there are sortbottom rows,
+    // for backwards compatibility, move them to tfoot (creating it if n=
eeded).
+    sortbottomrows =3D [];
+    for (var i=3D0; i<table.rows.length; i++) {
+      if (table.rows[i].className.search(/\bsortbottom\b/) !=3D -1) {
+        sortbottomrows[sortbottomrows.length] =3D table.rows[i];
+      }
+    }
+    if (sortbottomrows) {
+      if (table.tFoot =3D=3D null) {
+        // table doesn't have a tfoot. Create one.
+        tfo =3D document.createElement('tfoot');
+        table.appendChild(tfo);
+      }
+      for (var i=3D0; i<sortbottomrows.length; i++) {
+        tfo.appendChild(sortbottomrows[i]);
+      }
+      delete sortbottomrows;
+    }
+
+    // work through each column and calculate its type
+    headrow =3D table.tHead.rows[0].cells;
+    for (var i=3D0; i<headrow.length; i++) {
+      // manually override the type with a sorttable_type attribute
+      if (!headrow[i].className.match(/\bsorttable_nosort\b/)) { // skip=
 this col
+        mtch =3D headrow[i].className.match(/\bsorttable_([a-z0-9]+)\b/)=
;
+        if (mtch) { override =3D mtch[1]; }
+	      if (mtch && typeof sorttable["sort_"+override] =3D=3D 'function')=
 {
+	        headrow[i].sorttable_sortfunction =3D sorttable["sort_"+overrid=
e];
+	      } else {
+	        headrow[i].sorttable_sortfunction =3D sorttable.guessType(table=
,i);
+	      }
+	      // make it clickable to sort
+	      headrow[i].sorttable_columnindex =3D i;
+	      headrow[i].sorttable_tbody =3D table.tBodies[0];
+	      dean_addEvent(headrow[i],"click", sorttable.innerSortFunction =3D=
 function(e) {
+
+          if (this.className.search(/\bsorttable_sorted\b/) !=3D -1) {
+            // if we're already sorted by this column, just
+            // reverse the table, which is quicker
+            sorttable.reverse(this.sorttable_tbody);
+            this.className =3D this.className.replace('sorttable_sorted'=
,
+                                                    'sorttable_sorted_re=
verse');
+            this.removeChild(document.getElementById('sorttable_sortfwdi=
nd'));
+            sortrevind =3D document.createElement('span');
+            sortrevind.id =3D "sorttable_sortrevind";
+            sortrevind.innerHTML =3D stIsIE ? '&nbsp<font face=3D"webdin=
gs">5</font>' : '&nbsp;&#x25B4;';
+            this.appendChild(sortrevind);
+            return;
+          }
+          if (this.className.search(/\bsorttable_sorted_reverse\b/) !=3D=
 -1) {
+            // if we're already sorted by this column in reverse, just
+            // re-reverse the table, which is quicker
+            sorttable.reverse(this.sorttable_tbody);
+            this.className =3D this.className.replace('sorttable_sorted_=
reverse',
+                                                    'sorttable_sorted');
+            this.removeChild(document.getElementById('sorttable_sortrevi=
nd'));
+            sortfwdind =3D document.createElement('span');
+            sortfwdind.id =3D "sorttable_sortfwdind";
+            sortfwdind.innerHTML =3D stIsIE ? '&nbsp<font face=3D"webdin=
gs">6</font>' : '&nbsp;&#x25BE;';
+            this.appendChild(sortfwdind);
+            return;
+          }
+
+          // remove sorttable_sorted classes
+          theadrow =3D this.parentNode;
+          forEach(theadrow.childNodes, function(cell) {
+            if (cell.nodeType =3D=3D 1) { // an element
+              cell.className =3D cell.className.replace('sorttable_sorte=
d_reverse','');
+              cell.className =3D cell.className.replace('sorttable_sorte=
d','');
+            }
+          });
+          sortfwdind =3D document.getElementById('sorttable_sortfwdind')=
;
+          if (sortfwdind) { sortfwdind.parentNode.removeChild(sortfwdind=
); }
+          sortrevind =3D document.getElementById('sorttable_sortrevind')=
;
+          if (sortrevind) { sortrevind.parentNode.removeChild(sortrevind=
); }
+
+          this.className +=3D ' sorttable_sorted';
+          sortfwdind =3D document.createElement('span');
+          sortfwdind.id =3D "sorttable_sortfwdind";
+          sortfwdind.innerHTML =3D stIsIE ? '&nbsp<font face=3D"webdings=
">6</font>' : '&nbsp;&#x25BE;';
+          this.appendChild(sortfwdind);
+
+	        // build an array to sort. This is a Schwartzian transform thin=
g,
+	        // i.e., we "decorate" each row with the actual sort key,
+	        // sort based on the sort keys, and then put the rows back in o=
rder
+	        // which is a lot faster because you only do getInnerText once =
per row
+	        row_array =3D [];
+	        col =3D this.sorttable_columnindex;
+	        rows =3D this.sorttable_tbody.rows;
+	        for (var j=3D0; j<rows.length; j++) {
+	          row_array[row_array.length] =3D [sorttable.getInnerText(rows[=
j].cells[col]), rows[j]];
+	        }
+	        /* If you want a stable sort, uncomment the following line */
+	        sorttable.shaker_sort(row_array, this.sorttable_sortfunction);
+	        /* and comment out this one */
+	        //row_array.sort(this.sorttable_sortfunction);
+
+	        tb =3D this.sorttable_tbody;
+	        for (var j=3D0; j<row_array.length; j++) {
+	          tb.appendChild(row_array[j][1]);
+	        }
+
+	        delete row_array;
+	      });
+	    }
+    }
+  },
+
+  guessType: function(table, column) {
+    // guess the type of a column based on its first non-blank row
+    sortfn =3D sorttable.sort_alpha;
+    for (var i=3D0; i<table.tBodies[0].rows.length; i++) {
+      text =3D sorttable.getInnerText(table.tBodies[0].rows[i].cells[col=
umn]);
+      if (text !=3D '') {
+        if (text.match(/^-?[=EF=BF=BD$=EF=BF=BD]?[\d,.]+%?$/)) {
+          return sorttable.sort_numeric;
+        }
+        // check for a date: dd/mm/yyyy or dd/mm/yy
+        // can have / or . or - as separator
+        // can be mm/dd as well
+        possdate =3D text.match(sorttable.DATE_RE)
+        if (possdate) {
+          // looks like a date
+          first =3D parseInt(possdate[1]);
+          second =3D parseInt(possdate[2]);
+          if (first > 12) {
+            // definitely dd/mm
+            return sorttable.sort_ddmm;
+          } else if (second > 12) {
+            return sorttable.sort_mmdd;
+          } else {
+            // looks like a date, but we can't tell which, so assume
+            // that it's dd/mm (English imperialism!) and keep looking
+            sortfn =3D sorttable.sort_ddmm;
+          }
+        }
+      }
+    }
+    return sortfn;
+  },
+
+  getInnerText: function(node) {
+    // gets the text we want to use for sorting for a cell.
+    // strips leading and trailing whitespace.
+    // this is *not* a generic getInnerText function; it's special to so=
rttable.
+    // for example, you can override the cell text with a customkey attr=
ibute.
+    // it also gets .value for <input> fields.
+
+    if (!node) return "";
+
+    hasInputs =3D (typeof node.getElementsByTagName =3D=3D 'function') &=
&
+                 node.getElementsByTagName('input').length;
+
+    if (node.getAttribute("sorttable_customkey") !=3D null) {
+      return node.getAttribute("sorttable_customkey");
+    }
+    else if (typeof node.textContent !=3D 'undefined' && !hasInputs) {
+      return node.textContent.replace(/^\s+|\s+$/g, '');
+    }
+    else if (typeof node.innerText !=3D 'undefined' && !hasInputs) {
+      return node.innerText.replace(/^\s+|\s+$/g, '');
+    }
+    else if (typeof node.text !=3D 'undefined' && !hasInputs) {
+      return node.text.replace(/^\s+|\s+$/g, '');
+    }
+    else {
+      switch (node.nodeType) {
+        case 3:
+          if (node.nodeName.toLowerCase() =3D=3D 'input') {
+            return node.value.replace(/^\s+|\s+$/g, '');
+          }
+        case 4:
+          return node.nodeValue.replace(/^\s+|\s+$/g, '');
+          break;
+        case 1:
+        case 11:
+          var innerText =3D '';
+          for (var i =3D 0; i < node.childNodes.length; i++) {
+            innerText +=3D sorttable.getInnerText(node.childNodes[i]);
+          }
+          return innerText.replace(/^\s+|\s+$/g, '');
+          break;
+        default:
+          return '';
+      }
+    }
+  },
+
+  reverse: function(tbody) {
+    // reverse the rows in a tbody
+    newrows =3D [];
+    for (var i=3D0; i<tbody.rows.length; i++) {
+      newrows[newrows.length] =3D tbody.rows[i];
+    }
+    for (var i=3Dnewrows.length-1; i>=3D0; i--) {
+       tbody.appendChild(newrows[i]);
+    }
+    delete newrows;
+  },
+
+  /* sort functions
+     each sort function takes two parameters, a and b
+     you are comparing a[0] and b[0] */
+  sort_numeric: function(a,b) {
+    aa =3D parseFloat(a[0].replace(/[^0-9.-]/g,''));
+    if (isNaN(aa)) aa =3D 0;
+    bb =3D parseFloat(b[0].replace(/[^0-9.-]/g,''));
+    if (isNaN(bb)) bb =3D 0;
+    return aa-bb;
+  },
+  sort_alpha: function(a,b) {
+    if (a[0]=3D=3Db[0]) return 0;
+    if (a[0]<b[0]) return -1;
+    return 1;
+  },
+  sort_ddmm: function(a,b) {
+    mtch =3D a[0].match(sorttable.DATE_RE);
+    y =3D mtch[3]; m =3D mtch[2]; d =3D mtch[1];
+    if (m.length =3D=3D 1) m =3D '0'+m;
+    if (d.length =3D=3D 1) d =3D '0'+d;
+    dt1 =3D y+m+d;
+    mtch =3D b[0].match(sorttable.DATE_RE);
+    y =3D mtch[3]; m =3D mtch[2]; d =3D mtch[1];
+    if (m.length =3D=3D 1) m =3D '0'+m;
+    if (d.length =3D=3D 1) d =3D '0'+d;
+    dt2 =3D y+m+d;
+    if (dt1=3D=3Ddt2) return 0;
+    if (dt1<dt2) return -1;
+    return 1;
+  },
+  sort_mmdd: function(a,b) {
+    mtch =3D a[0].match(sorttable.DATE_RE);
+    y =3D mtch[3]; d =3D mtch[2]; m =3D mtch[1];
+    if (m.length =3D=3D 1) m =3D '0'+m;
+    if (d.length =3D=3D 1) d =3D '0'+d;
+    dt1 =3D y+m+d;
+    mtch =3D b[0].match(sorttable.DATE_RE);
+    y =3D mtch[3]; d =3D mtch[2]; m =3D mtch[1];
+    if (m.length =3D=3D 1) m =3D '0'+m;
+    if (d.length =3D=3D 1) d =3D '0'+d;
+    dt2 =3D y+m+d;
+    if (dt1=3D=3Ddt2) return 0;
+    if (dt1<dt2) return -1;
+    return 1;
+  },
+
+  shaker_sort: function(list, comp_func) {
+    // A stable sort function to allow multi-level sorting of data
+    // see: http://en.wikipedia.org/wiki/Cocktail_sort
+    // thanks to Joseph Nahmias
+    var b =3D 0;
+    var t =3D list.length - 1;
+    var swap =3D true;
+
+    while(swap) {
+        swap =3D false;
+        for(var i =3D b; i < t; ++i) {
+            if ( comp_func(list[i], list[i+1]) > 0 ) {
+                var q =3D list[i]; list[i] =3D list[i+1]; list[i+1] =3D =
q;
+                swap =3D true;
+            }
+        } // for
+        t--;
+
+        if (!swap) break;
+
+        for(var i =3D t; i > b; --i) {
+            if ( comp_func(list[i], list[i-1]) < 0 ) {
+                var q =3D list[i]; list[i] =3D list[i-1]; list[i-1] =3D =
q;
+                swap =3D true;
+            }
+        } // for
+        b++;
+
+    } // while(swap)
+  }
+}
+
+/* ******************************************************************
+   Supporting functions: bundled here to avoid depending on a library
+   ****************************************************************** */
+
+// Dean Edwards/Matthias Miller/John Resig
+
+/* for Mozilla/Opera9 */
+if (document.addEventListener) {
+    document.addEventListener("DOMContentLoaded", sorttable.init, false)=
;
+}
+
+/* for Internet Explorer */
+/*@cc_on @*/
+/*@if (@_win32)
+    document.write("<script id=3D__ie_onload defer src=3Djavascript:void=
(0)><\/script>");
+    var script =3D document.getElementById("__ie_onload");
+    script.onreadystatechange =3D function() {
+        if (this.readyState =3D=3D "complete") {
+            sorttable.init(); // call the onload handler
+        }
+    };
+/*@end @*/
+
+/* for Safari */
+if (/WebKit/i.test(navigator.userAgent)) { // sniff
+    var _timer =3D setInterval(function() {
+        if (/loaded|complete/.test(document.readyState)) {
+            sorttable.init(); // call the onload handler
+        }
+    }, 10);
+}
+
+/* for other browsers */
+window.onload =3D sorttable.init;
+
+// written by Dean Edwards, 2005
+// with input from Tino Zijdel, Matthias Miller, Diego Perini
+
+// http://dean.edwards.name/weblog/2005/10/add-event/
+
+function dean_addEvent(element, type, handler) {
+	if (element.addEventListener) {
+		element.addEventListener(type, handler, false);
+	} else {
+		// assign each event handler a unique ID
+		if (!handler.$$guid) handler.$$guid =3D dean_addEvent.guid++;
+		// create a hash table of event types for the element
+		if (!element.events) element.events =3D {};
+		// create a hash table of event handlers for each element/event pair
+		var handlers =3D element.events[type];
+		if (!handlers) {
+			handlers =3D element.events[type] =3D {};
+			// store the existing event handler (if there is one)
+			if (element["on" + type]) {
+				handlers[0] =3D element["on" + type];
+			}
+		}
+		// store the event handler in the hash table
+		handlers[handler.$$guid] =3D handler;
+		// assign a global event handler to do all the work
+		element["on" + type] =3D handleEvent;
+	}
+};
+// a counter used to create unique IDs
+dean_addEvent.guid =3D 1;
+
+function removeEvent(element, type, handler) {
+	if (element.removeEventListener) {
+		element.removeEventListener(type, handler, false);
+	} else {
+		// delete the event handler from the hash table
+		if (element.events && element.events[type]) {
+			delete element.events[type][handler.$$guid];
+		}
+	}
+};
+
+function handleEvent(event) {
+	var returnValue =3D true;
+	// grab the event object (IE uses a global event object)
+	event =3D event || fixEvent(((this.ownerDocument || this.document || th=
is).parentWindow || window).event);
+	// get a reference to the hash table of event handlers
+	var handlers =3D this.events[event.type];
+	// execute each event handler
+	for (var i in handlers) {
+		this.$$handleEvent =3D handlers[i];
+		if (this.$$handleEvent(event) =3D=3D=3D false) {
+			returnValue =3D false;
+		}
+	}
+	return returnValue;
+};
+
+function fixEvent(event) {
+	// add W3C standard event methods
+	event.preventDefault =3D fixEvent.preventDefault;
+	event.stopPropagation =3D fixEvent.stopPropagation;
+	return event;
+};
+fixEvent.preventDefault =3D function() {
+	this.returnValue =3D false;
+};
+fixEvent.stopPropagation =3D function() {
+  this.cancelBubble =3D true;
+}
+
+// Dean's forEach: http://dean.edwards.name/base/forEach.js
+/*
+	forEach, version 1.0
+	Copyright 2006, Dean Edwards
+	License: http://www.opensource.org/licenses/mit-license.php
+*/
+
+// array-like enumeration
+if (!Array.forEach) { // mozilla already supports this
+	Array.forEach =3D function(array, block, context) {
+		for (var i =3D 0; i < array.length; i++) {
+			block.call(context, array[i], i, array);
+		}
+	};
+}
+
+// generic enumeration
+Function.prototype.forEach =3D function(object, block, context) {
+	for (var key in object) {
+		if (typeof this.prototype[key] =3D=3D "undefined") {
+			block.call(context, object[key], key, object);
+		}
+	}
+};
+
+// character enumeration
+String.forEach =3D function(string, block, context) {
+	Array.forEach(string.split(""), function(chr, index) {
+		block.call(context, chr, index, string);
+	});
+};
+
+// globally resolve forEach enumeration
+var forEach =3D function(object, block, context) {
+	if (object) {
+		var resolve =3D Object; // default
+		if (object instanceof Function) {
+			// functions have a "length" property
+			resolve =3D Function;
+		} else if (object.forEach instanceof Function) {
+			// the object implements a custom forEach method so use that
+			object.forEach(block, context);
+			return;
+		} else if (typeof object =3D=3D "string") {
+			// the object is a string
+			resolve =3D String;
+		} else if (typeof object.length =3D=3D "number") {
+			// the object is array-like
+			resolve =3D Array;
+		}
+		resolve.forEach(object, block, context);
+	}
+};
+
--=20
2.43.0


