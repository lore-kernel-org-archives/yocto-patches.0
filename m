Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610DCC19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 16:44:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.18109.1741193089290371633
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 08:44:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBA491007
	for <yocto-patches@lists.yoctoproject.org>; Wed,  5 Mar 2025 08:45:01 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 403043F5A1
	for <yocto-patches@lists.yoctoproject.org>; Wed,  5 Mar 2025 08:44:48 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 1/2] dashboard: add new bug triage page
Date: Wed,  5 Mar 2025 16:44:42 +0000
Message-ID: <20250305164443.3080640-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 16:44:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1157

Add a replacement for the the existing Bug Triage page on the wiki[1].

This uses client-side JavaScript to parse the releases.json and query
Bugzilla, so shouldn't need updating very often.

[1] https://wiki.yoctoproject.org/wiki/Bug_Triage

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 402 +++++++++++++++++++++++++
 scripts/dashboard/index.html           |   4 +-
 scripts/run-dashboard-index            |   3 +-
 3 files changed, 406 insertions(+), 3 deletions(-)
 create mode 100644 scripts/dashboard/bugtriage/index.html

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
new file mode 100644
index 00000000..161df2a5
--- /dev/null
+++ b/scripts/dashboard/bugtriage/index.html
@@ -0,0 +1,402 @@
+<!DOCTYPE html>
+<html lang=3D"en">
+
+<head>
+  <meta charset=3D"UTF-8">
+  <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-scale=
=3D1.0">
+  <title>Bug Triage</title>
+  <link href=3D"https://fonts.googleapis.com/icon?family=3DMaterial+Icon=
s" rel=3D"stylesheet">
+  <link rel=3D"stylesheet" href=3D"https://cdnjs.cloudflare.com/ajax/lib=
s/materialize/1.0.0/css/materialize.min.css">
+  <style>
+    .pin-top {
+      position: relative;
+    }
+
+    .pin-bottom {
+      position: relative;
+    }
+
+    .pinned {
+      position: fixed !important;
+    }
+
+    .table-of-contents a.active {
+      border-left-color: #03a9f4;
+    }
+  </style>
+</head>
+
+<body>
+  <nav>
+    <div class=3D"nav-wrapper light-blue" id=3D"nav">
+      <span class=3D"brand-logo">&nbsp;Yocto Project Bug Triage</span>
+      <ul id=3D"nav-mobile" class=3D"right hide-on-med-and-down">
+        <li><a href=3D"https://bugzilla.yoctoproject.org/">Bugzilla</a><=
/li>
+        <li><a href=3D"https://autobuilder.yoctoproject.org/">Autobuilde=
r</a></li>
+      </ul>
+    </div>
+  </nav>
+
+  <div class=3D"row">
+    <div class=3D"col s12 m9 l10">
+      <p>
+        The outcome of the bug triage meeting should be that all bugs ha=
ve an
+        owner, a target milestone, and a priority.
+      </p>
+      <p>
+        The meeting is held every Thursday at 07:30 Pacific Time (typica=
lly
+        15:30 GMT or 16:30 CET, but be aware of daylight saving shifts).=
 The
+        meeting is held on <a href=3D"https://zoom.us/">Zoom</a>, join w=
ith either the <a
+        href=3D"https://zoom.us/j/454367603?pwd=3DZGxoa2ZXL3FkM3Y0bFd5aV=
pHVVZ6dz09">direct
+        link</a> or use the Meeting ID <strong>454-367-603</strong> and =
password
+        <strong>277925</strong>.
+      </p>
+      <p>
+        The call facilitator is Stephen Jolley &lt;<a
+        href=3D"mailto:sjolley.yp.pm@gmail.com">sjolley.yp.pm@gmail.com<=
/a>&gt;. The
+        facilitator's job is to ensure the agenda is kept to, without ra=
tholing
+        on any particular bug, and keeping to the time slot.
+      </p>
+
+      <div class=3D"section scrollspy" id=3D"security-container">
+        <h4>Security-related</h4>
+        <p>
+          <a href=3D"https://bugzilla.yoctoproject.org/buglist.cgi?list_=
id=3D604307&resolution=3D---&query_format=3Dadvanced&bug_status=3DUNCONFI=
RMED&bug_status=3DNEW&bug_status=3DACCEPTED&bug_status=3DIN%20PROGRESS%20=
DESIGN&bug_status=3DIN%20PROGRESS%20DESIGN%20COMPLETE&bug_status=3DIN%20P=
ROGRESS%20IMPLEMENTATION&bug_status=3DIN%20PROGRESS%20REVIEW&bug_status=3D=
REOPENED&bug_status=3DNEEDINFO&product=3DSecurity&product=3DSecurity%20-%=
20Recipe%20Upgrade" target=3D"_blank">View security-related bugs in Bugzi=
lla</a>.
+        </p>
+        <p>
+          Security issues a need to be viewed directly in Bugzilla as th=
ey are
+          only visible to users with sufficient permissions.
+        </p>
+      </div>
+
+      <div class=3D"section scrollspy" id=3D"unprioritised-container">
+        <h4>Unprioritised <a class=3D"waves-effect btn-flat" onclick=3D"=
reloadTable('#unprioritised');"><i class=3D"material-icons">refresh</i></=
a></h4>
+        <p>
+          Bugs without a priority, that need a priority, target mileston=
e, and owner assigned.
+        </p>
+        <div id=3D"unprioritised"></div>
+      </div>
+
+      <div class=3D"section scrollspy" id=3D"high-container">
+        <h4>High <a class=3D"waves-effect btn-flat" onclick=3D"reloadTab=
le('#high');"><i class=3D"material-icons">refresh</i></a></h4>
+        <p>
+          All open high-priority bugs.
+        </p>
+        <div id=3D"high"></div>
+      </div>
+
+      <div class=3D"section scrollspy" id=3D"abint-container">
+        <h4>Autobuilder Intermittent <a class=3D"waves-effect btn-flat" =
onclick=3D"reloadTable('#abint');"><i class=3D"material-icons">refresh</i=
></a></h4>
+        <p>
+          Bugs which are tagged as tracking intermittent failures on the
+          autobuilder. A <a
+          href=3D"https://valkyrie.yocto.io/pub/non-release/abint/" targ=
et=3D"_blank">graphical
+          view</a> is also available.
+        </p>
+        <div id=3D"abint"></div>
+      </div>
+
+      <div class=3D"section scrollspy" id=3D"reopened-container">
+        <h4>Reopened <a class=3D"waves-effect btn-flat" onclick=3D"reloa=
dTable('#reopened');"><i class=3D"material-icons">refresh</i></a></h4>
+        <p>
+          Bugs that have been reopened. The owner should be reviewed and=
 the bug
+          moved to another state.
+        </p>
+        <div id=3D"reopened"></div>
+      </div>
+
+      <div class=3D"section scrollspy" id=3D"needinfo-container">
+        <h4>Need Info <a class=3D"waves-effect btn-flat" onclick=3D"relo=
adTable('#needinfo');"><i class=3D"material-icons">refresh</i></a></h4>
+        <p>
+          All bugs that are in the NEEDINFO state, and should be reviewe=
d to
+          identify if the information has been provided and the bug shou=
ld be
+          moved to another state.
+        </p>
+        <div id=3D"needinfo"></div>
+      </div>
+
+      <div class=3D"section scrollspy" id=3D"inactive-container">
+        <h4>Inactive <a class=3D"waves-effect btn-flat" onclick=3D"reloa=
dTable('#inactive');"><i class=3D"material-icons">refresh</i></a></h4>
+        <p>
+          All open bugs that haven't been altered in two years.
+        </p>
+        <div id=3D"inactive"></div>
+      </div>
+
+      <div class=3D"section scrollspy" id=3D"oldmilestone-container">
+        <h4>Old Milestone <a class=3D"waves-effect btn-flat" onclick=3D"=
reloadTable('#oldmilestone');"><i class=3D"material-icons">refresh</i></a=
></h4>
+        <p>
+          All open bugs that are targetted for a milestone in the past: =
they
+          should be closed or moved to a future milestone.
+        </p>
+        <div id=3D"oldmilestone"></div>
+      </div>
+
+      <div class=3D"section scrollspy" id=3D"newcomer-container">
+        <h4>Potential Newcomer <a class=3D"waves-effect btn-flat" onclic=
k=3D"reloadTable('#newcomer');"><i class=3D"material-icons">refresh</i></=
a></h4>
+        <p>
+          All open bugs which have been tagged as being potentially good=
 for
+          newcomers to the project who want to make their first contribu=
tion.
+        </p>
+        <div id=3D"newcomer"></div>
+      </div>
+    </div>
+
+    <div class=3D"col hide-on-small-only m3 l2">
+      <ul class=3D"section table-of-contents pushpin">
+        <li><a href=3D"#security-container">Security</a></li>
+        <li><a href=3D"#unprioritised-container">Unprioritised</a></li>
+        <li><a href=3D"#high-container">High</a></li>
+        <li><a href=3D"#abint-container">AB-INT</a></li>
+        <li><a href=3D"#reopened-container">Reopened</a></li>
+        <li><a href=3D"#needinfo-container">Need Info</a></li>
+        <li><a href=3D"#inactive-container">Inactive</a></li>
+        <li><a href=3D"#oldmilestone-container">Old Milestone</a></li>
+        <li><a href=3D"#newcomer-container">Newcomer</a></li>
+      </ul>
+    </div>
+  </div>
+  </div>
+  <script>
+    const serverUrl =3D "https://bugzilla.yoctoproject.org";
+
+    const ignoreProducts =3D [
+      "opkg",
+      "Other YP Layers",
+      "Security Response Tool",
+      "Toaster",
+      "Yocto Project Compatible"
+    ];
+
+    // Fields to display (bugzilla field name -> column header)
+    const fields =3D new Map([
+      ["id", "ID"],
+      ["summary", "Summary"],
+      ["product", "Product"],
+      ["status", "Status"],
+      ["target_milestone", "Milestone"],
+      ["assigned_to", "Owner"],
+    ]);
+
+    function populateTable(selector, bugs) {
+      if (bugs.length =3D=3D=3D 0) {
+        const p =3D document.createElement("p");
+        p.innerHTML =3D "<em>No bugs found</em>.";
+        document.querySelector(selector).replaceChildren(p);
+        return;
+      }
+
+      const table =3D document.createElement("table");
+      table.setAttribute("class", "highlight")
+
+      const header =3D table.appendChild(document.createElement("thead")=
);
+      const tr =3D header.appendChild(document.createElement("tr"));
+      for (const value of fields.values()) {
+        tr.appendChild(document.createElement("th")).append(value);
+      }
+
+      const body =3D table.appendChild(document.createElement("tbody"));
+      for (const bug of bugs) {
+        const row =3D body.appendChild(document.createElement("tr"));
+        for (const field of fields.keys()) {
+          const td =3D row.appendChild(document.createElement("td"));
+          if (field =3D=3D=3D "id")
+            td.innerHTML =3D `<a href=3D"${serverUrl}/show_bug.cgi?id=3D=
${bug.id}" target=3D"_blank">${bug.id}</a>`
+          else
+            td.innerHTML =3D bug[field];
+        }
+      }
+
+      const footer =3D table.appendChild(document.createElement("tfoot")=
);
+      footer.innerHTML =3D `<tr><td colspan=3D"${fields.size}">${bugs.le=
ngth} bugs found.</td></tr>`;
+
+      document.querySelector(selector).replaceChildren(table);
+    }
+
+    async function searchBugs(selector, params) {
+      const spinner =3D document.createElement("div");
+      spinner.setAttribute("class", "progress")
+      spinner.innerHTML =3D `<div class=3D"indeterminate"></div>`;
+      document.querySelector(selector).replaceChildren(spinner);
+
+      try {
+        params.append("include_fields", Array.from(fields.keys()).join()=
);
+        params.append("f0", "product",)
+        params.append("o0", "notregexp",)
+        params.append("v0", `^(${ignoreProducts.map((s) =3D> escapeRegEx=
p(s)).join("|")})$`)
+
+        const response =3D await fetch(`${serverUrl}/rest/bug?${params}`=
);
+        if (!response.ok) {
+          throw new Error(`Failed to fetch: ${response.statusText}`);
+        }
+
+        const data =3D await response.json();
+        populateTable(selector, data.bugs);
+      } catch (error) {
+        console.error(`Failed to fetch bugs for ${selector}: ${error}`);
+        alert("Error fetching bugs. Check the console for details.");
+      }
+    }
+
+    async function bugsByWhiteboard(table, keyword) {
+      const params =3D new URLSearchParams({
+        resolution: "---",
+        whiteboard: keyword,
+      });
+      const bugs =3D await searchBugs(table, params);
+    }
+
+    async function bugsByPriority(table, priority) {
+      const params =3D new URLSearchParams({
+        resolution: "---",
+        priority: priority
+      });
+      const bugs =3D await searchBugs(table, params);
+    }
+
+    async function bugsByStatus(table, status) {
+      const params =3D new URLSearchParams({
+        status: status
+      });
+      const bugs =3D await searchBugs(table, params);
+    }
+
+    async function bugsInactive(table) {
+      const params =3D new URLSearchParams({
+        resolution: "---",
+        f1: "days_elapsed",
+        o1: "greaterthaneq",
+        v1: 365 * 2
+      });
+      const bugs =3D await searchBugs(table, params);
+    }
+
+    function escapeRegExp(string) {
+      // In the Glorious Future we can use RegExp.escape()
+      return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
+    }
+
+    async function getActiveReleases() {
+      // Download releases.json and use it to generate the active milest=
ones.
+
+      // Start with milestones that are always active
+      const active =3D [
+        "---",
+        "0.0.0",
+        "5.99",
+        "Q1",
+        "Q2",
+        "Q3",
+        "Q4",
+        "future"
+      ];
+
+      const response =3D await fetch("https://dashboard.yoctoproject.org=
/releases.json");
+      if (!response.ok) {
+        throw new Error(`Failed to fetch releases: ${response.statusText=
}`);
+      }
+
+      const releases =3D await response.json();
+      for (const release of releases) {
+        if (release.series !=3D=3D "current")
+          continue
+
+        if (release.latest_tag) {
+          // If there is a latest_tag set then this series has been rele=
ases, so
+          // add point releases.
+
+          const parts =3D release.latest_tag.split(".");
+          // Pad to three digits if needed
+          const origlen =3D parts.length;
+          parts.length =3D 3;
+          parts.fill(0, origlen);
+
+          // Add the next three point releases
+          for (let i =3D 0; i < 3; i++) {
+            // Let JavaScript so-called-typing ignore the fact that we'r=
e incrementing a string
+            parts[parts.length - 1]++;
+            active.push(parts.join("."));
+          }
+        } else {
+          // If there's not a latest_tag set then this is the current de=
velopment cycle.
+
+          // The current major release is active
+          active.push(release.series_version);
+          // And so is the next major release
+          const parts =3D release.series_version.split(".")
+          parts[parts.length - 1]++;
+          active.push(parts.join("."));
+
+          // All remaining milestones in this release
+          let milestones =3D new Set([1, 2, 3, 4].map((m) =3D> `${releas=
e.series_version} M${m}`));
+          // Remove the milestones that have been releases. Map the tag =
names to milestone names here.
+          const seenMilestones =3D new Set(release.releases.map((s) =3D>=
 s.replace("_", " ")));
+          milestones =3D milestones.difference(seenMilestones);
+          active.push(...milestones);
+        }
+      }
+      return active;
+    }
+
+    async function bugsOldMilestone(table) {
+      const activeMilestones =3D await getActiveReleases();
+
+      const params =3D new URLSearchParams({
+        resolution: "---",
+        f1: "target_milestone",
+        o1: "notregexp",
+        v1: `^(${activeMilestones.map((s) =3D> escapeRegExp(s)).join("|"=
)})$`
+      });
+      const bugs =3D await searchBugs(table, params);
+    }
+
+    function reloadTable(table) {
+      switch (table) {
+        case "#unprioritised":
+          bugsByPriority(table, "Undecided");
+          break;
+        case "#high":
+          bugsByPriority(table, "High");
+          break;
+        case "#abint":
+          bugsByWhiteboard(table, "AB-INT");
+          break;
+        case "#newcomer":
+          bugsByWhiteboard(table, "NEWCOMER");
+          break;
+        case "#reopened":
+          bugsByStatus(table, "REOPENED");
+          break;
+        case "#needinfo":
+          bugsByStatus(table, "NEEDINFO");
+          break;
+        case "#inactive":
+          bugsInactive(table);
+          break;
+        case "#oldmilestone":
+          bugsOldMilestone(table);
+          break;
+      }
+    }
+
+    reloadTable("#unprioritised");
+    reloadTable("#high");
+    reloadTable("#abint");
+    reloadTable("#newcomer");
+    reloadTable("#reopened");
+    reloadTable("#needinfo");
+    reloadTable("#inactive");
+    reloadTable("#oldmilestone");
+
+    document.addEventListener('DOMContentLoaded', function () {
+      var elems =3D document.querySelectorAll('.scrollspy');
+      M.ScrollSpy.init(elems, { scrollOffset: 100 });
+
+      elems =3D document.querySelectorAll('.pushpin');
+      M.Pushpin.init(elems, { offset: document.querySelector("#nav").off=
setHeight });
+    });
+  </script>
+  <script src=3D"https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.=
0/js/materialize.min.js"></script>
+</body>
+
+</html>
diff --git a/scripts/dashboard/index.html b/scripts/dashboard/index.html
index 73989ee6..1d7830fa 100644
--- a/scripts/dashboard/index.html
+++ b/scripts/dashboard/index.html
@@ -29,7 +29,9 @@ font-family: Tahoma, Verdana, Arial, sans-serif; }
 <br/>
 <br/>
 <a href=3D"https://valkyrie.yocto.io/pub/">Autobuilder unreleased build =
output</a>
+<br/>
+<br/>
+<a href=3D"bugtriage/">Bug Triage</a>
 </p>
-<p><em></em></p>
 </body>
 </html>
diff --git a/scripts/run-dashboard-index b/scripts/run-dashboard-index
index 47c5e9a7..b898c9b9 100755
--- a/scripts/run-dashboard-index
+++ b/scripts/run-dashboard-index
@@ -18,5 +18,4 @@ $scriptdir/layer-parser.py
=20
 rsync -irlp --checksum --ignore-times releases.json docs@docs.yoctoproje=
ct.org:dashboard/
 rsync -irlp --checksum --ignore-times parsed-layers.json docs@docs.yocto=
project.org:dashboard/
-rsync -irlp --checksum --ignore-times $scriptdir/dashboard/index.html do=
cs@docs.yoctoproject.org:dashboard/
-
+rsync -irlp --checksum --ignore-times $scriptdir/dashboard/ docs@docs.yo=
ctoproject.org:dashboard/
--=20
2.43.0


