Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A086C88E4D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 21:03:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.49635.1789160636130544245
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 14:03:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=dQSslJCq;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E43B2E96
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:51 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 023A53F8C6
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789160635; bh=pNeWFg7O6CwwH8iHaBAqqL8Z0DjxToSQPzlMGy1A0i8=;
	h=From:To:Subject:Date:From;
	b=dQSslJCqcEyhb8tBBG5h4urp8VIzhdUloEzq84qjjp0BqcPfh7OOu43dUAhCIbqMh
	 2WP3R4mhpps852QZ/zFcywvj4oX69a3JQkL01PPRMDjfJo2nn2RWJ3nzkzFMDPvqSv
	 8nkVtyYPLdMX+DzedByHcicJLro5WFdtRUbe58To=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 1/8] dashboard/bugtriage: reformat HTML
Date: Fri, 11 Sep 2026 22:03:44 +0100
Message-ID: <20260911210351.2020798-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 21:03:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4816

Reformat the HTML and JavaScript as it was getting a little messy.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 80 +++++++++++++++++---------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index ee4f4019..8427b0d1 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -12,7 +12,6 @@
   <link rel=3D"icon" type=3D"image/png" sizes=3D"16x16" href=3D"../resou=
rces/favicon-16x16.png">
   <script src=3D"vanillajs-scrollspy.min.js"></script>
   <style>
-
     body {
       font-size: 0.9rem;
     }
@@ -108,7 +107,11 @@
       animation: spinner 2s infinite linear;
     }
=20
-    @keyframes spinner {to{transform: rotate(1turn)}}
+    @keyframes spinner {
+      to {
+        transform: rotate(1turn)
+      }
+    }
=20
     [href=3D"#top"] {
       cursor: pointer;
@@ -143,7 +146,7 @@
       width: 1em;
       height: 1em;
     }
-   =20
+
     @media (prefers-color-scheme: dark) {
       th span:after {
         color: #EEE;
@@ -155,20 +158,20 @@
       background-image: url("data:image/svg+xml,%3Csvg xmlns=3D'http://w=
ww.w3.org/2000/svg' viewBox=3D'0 0 640 640'%3E%3C!--!Font Awesome Free v7=
.2.0 by @fontawesome - https://fontawesome.com License - https://fontawes=
ome.com/license/free Copyright 2026 Fonticons, Inc.--%3E%3Cpath d=3D'M160=
 288C147.1 288 135.4 280.2 130.4 268.2C125.4 256.2 128.2 242.5 137.4 233.=
4L297.4 73.4C309.9 60.9 330.2 60.9 342.7 73.4L502.7 233.4C511.9 242.6 514=
.6 256.3 509.6 268.3C504.6 280.3 492.9 288 480 288L160 288z'/%3E%3C/svg%3=
E");
       opacity: 1;
     }
-   =20
+
     th[aria-sort=3D"descending"] span:after {
       content: "";
       background-image: url("data:image/svg+xml,%3Csvg xmlns=3D'http://w=
ww.w3.org/2000/svg' viewBox=3D'0 0 640 640'%3E%3C!--!Font Awesome Free v7=
.2.0 by @fontawesome - https://fontawesome.com License - https://fontawes=
ome.com/license/free Copyright 2026 Fonticons, Inc.--%3E%3Cpath d=3D'M160=
 352C147.1 352 135.4 359.8 130.4 371.8C125.4 383.8 128.2 397.5 137.4 406.=
6L297.4 566.6C309.9 579.1 330.2 579.1 342.7 566.6L502.7 406.6C511.9 397.4=
 514.6 383.7 509.6 371.7C504.6 359.7 492.9 352 480 352L160 352z'/%3E%3C/s=
vg%3E");
       opacity: 1;
     }
=20
-    #nav-drawer-open,=20
+    #nav-drawer-open,
     #nav-drawer-close {
       display: none;
       cursor: pointer;
       font-size: 2.5rem;
       line-height: 0.9em;
-    }=20
+    }
=20
     #nav-drawer-open {
       margin-inline-end: 0.75em;
@@ -180,19 +183,22 @@
       margin-top: 0.35em;
       padding-inline-end: 0.4em;
     }
-   =20
+
     @media (max-width: 1023px) {
       body>main {
         padding-right: 0;
       }
-      #nav-drawer-open,=20
+
+      #nav-drawer-open,
       #nav-drawer-close {
         display: block;
-      }=20
+      }
+
       .spread {
         display: flex;
         justify-content: space-between;
       }
+
       .sticky {
         position: sticky;
         top: 0;
@@ -204,9 +210,10 @@
         z-index: 1;
       }
=20
-      body.show-nav .sidebar{
+      body.show-nav .sidebar {
         transform: translateX(0em);
       }
+
       .sidebar {
         display: block;
         position: fixed;
@@ -219,17 +226,21 @@
         overflow-y: auto;
         z-index: 2;
       }
+
       #table-of-contents {
         position: relative;
         margin-bottom: 2em;
       }
+
       section {
         margin-inline: 0;
       }
+
       .table-container {
         overflow-x: auto;
         max-width: 95vw;
       }
+
       /* make summary column fixed width on small screens */
       td:nth-child(2) {
         min-width: 30ch;
@@ -277,12 +288,14 @@
           <p>
             The meeting is held every Thursday at 07:30 Pacific Time (ty=
pically
             15:30 GMT or 16:30 CET, but be aware of daylight saving shif=
ts). The
-            meeting is held on <a href=3D"https://zoom.us/">Zoom</a>, jo=
in with either the <a href=3D"https://zoom.us/j/454367603?pwd=3DZGxoa2ZXL=
3FkM3Y0bFd5aVpHVVZ6dz09">direct
+            meeting is held on <a href=3D"https://zoom.us/">Zoom</a>, jo=
in with either the <a
+              href=3D"https://zoom.us/j/454367603?pwd=3DZGxoa2ZXL3FkM3Y0=
bFd5aVpHVVZ6dz09">direct
               link</a> or use the Meeting ID <strong>454-367-603</strong=
> and password
             <strong>277925</strong>.
           </p>
           <p>
-            The call facilitator is Stephen Jolley &lt;<a href=3D"mailto=
:sjolley.yp.pm@gmail.com">sjolley.yp.pm@gmail.com</a>&gt;. The
+            The call facilitator is Stephen Jolley &lt;<a
+              href=3D"mailto:sjolley.yp.pm@gmail.com">sjolley.yp.pm@gmai=
l.com</a>&gt;. The
             facilitator's job is to ensure the agenda is kept to, withou=
t ratholing
             on any particular bug, and keeping to the time slot.
           </p>
@@ -290,18 +303,20 @@
         <section id=3D"security-container" class=3D"table-container">
           <h4>Security-related</h4>
           <p>
-            <a href=3D"https://bugzilla.yoctoproject.org/buglist.cgi?lis=
t_id=3D604307&resolution=3D---&query_format=3Dadvanced&bug_status=3DUNCON=
FIRMED&bug_status=3DNEW&bug_status=3DACCEPTED&bug_status=3DIN%20PROGRESS%=
20DESIGN&bug_status=3DIN%20PROGRESS%20DESIGN%20COMPLETE&bug_status=3DIN%2=
0PROGRESS%20IMPLEMENTATION&bug_status=3DIN%20PROGRESS%20REVIEW&bug_status=
=3DREOPENED&bug_status=3DNEEDINFO&product=3DSecurity&product=3DSecurity%2=
0-%20Recipe%20Upgrade" target=3D"_blank">View security-related bugs in Bu=
gzilla</a>.
+            <a href=3D"https://bugzilla.yoctoproject.org/buglist.cgi?lis=
t_id=3D604307&resolution=3D---&query_format=3Dadvanced&bug_status=3DUNCON=
FIRMED&bug_status=3DNEW&bug_status=3DACCEPTED&bug_status=3DIN%20PROGRESS%=
20DESIGN&bug_status=3DIN%20PROGRESS%20DESIGN%20COMPLETE&bug_status=3DIN%2=
0PROGRESS%20IMPLEMENTATION&bug_status=3DIN%20PROGRESS%20REVIEW&bug_status=
=3DREOPENED&bug_status=3DNEEDINFO&product=3DSecurity&product=3DSecurity%2=
0-%20Recipe%20Upgrade"
+              target=3D"_blank">View security-related bugs in Bugzilla</=
a>.
           </p>
           <p>
             Security issues a need to be viewed directly in Bugzilla as =
they are
             only visible to users with sufficient permissions.
           </p>
         </section>
-       =20
+
         <section id=3D"unprioritised-container" class=3D"table-container=
">
           <span class=3D"spread">
             <span>
-              <h4>Unprioritised<span class=3D"bug-count"></span><a class=
=3D"reload-button" onclick=3D"reloadTable('#unprioritised');">Reload Bugs=
</a></h4>
+              <h4>Unprioritised<span class=3D"bug-count"></span><a class=
=3D"reload-button"
+                  onclick=3D"reloadTable('#unprioritised');">Reload Bugs=
</a></h4>
             </span>
           </span>
           <p>
@@ -313,7 +328,8 @@
         <section id=3D"high-container" class=3D"table-container">
           <span class=3D"spread">
             <span>
-              <h4>High<span class=3D"bug-count"></span><a class=3D"reloa=
d-button" onclick=3D"reloadTable('#high');">Reload Bugs</a></h4>
+              <h4>High<span class=3D"bug-count"></span><a class=3D"reloa=
d-button" onclick=3D"reloadTable('#high');">Reload
+                  Bugs</a></h4>
             </span>
           </span>
           <p>
@@ -325,7 +341,8 @@
         <section id=3D"reopened-container" class=3D"table-container">
           <span class=3D"spread">
             <span>
-              <h4>Reopened<span class=3D"bug-count"></span><a class=3D"r=
eload-button" onclick=3D"reloadTable('#reopened');">Reload Bugs</a></h4>
+              <h4>Reopened<span class=3D"bug-count"></span><a class=3D"r=
eload-button"
+                  onclick=3D"reloadTable('#reopened');">Reload Bugs</a><=
/h4>
             </span>
           </span>
           <p>
@@ -338,7 +355,8 @@
         <section id=3D"abint-container" class=3D"table-container">
           <span class=3D"spread">
             <span>
-              <h4>Autobuilder Intermittent<span class=3D"bug-count"></sp=
an><a class=3D"reload-button" onclick=3D"reloadTable('#abint');">Reload B=
ugs</a></h4>
+              <h4>Autobuilder Intermittent<span class=3D"bug-count"></sp=
an><a class=3D"reload-button"
+                  onclick=3D"reloadTable('#abint');">Reload Bugs</a></h4=
>
             </span>
           </span>
           <p>
@@ -352,7 +370,8 @@
         <section id=3D"needinfo-container" class=3D"table-container">
           <span class=3D"spread">
             <span>
-              <h4>Need Info<span class=3D"bug-count"></span><a class=3D"=
reload-button" onclick=3D"reloadTable('#needinfo');">Reload Bugs</a></h4>
+              <h4>Need Info<span class=3D"bug-count"></span><a class=3D"=
reload-button"
+                  onclick=3D"reloadTable('#needinfo');">Reload Bugs</a><=
/h4>
             </span>
           </span>
           <p>
@@ -366,7 +385,8 @@
         <section id=3D"oldmilestone-container" class=3D"table-container"=
>
           <span class=3D"spread">
             <span>
-              <h4>Wrong Milestone<span class=3D"bug-count"></span><a cla=
ss=3D"reload-button" onclick=3D"reloadTable('#oldmilestone');">Reload Bug=
s</a></h4>
+              <h4>Wrong Milestone<span class=3D"bug-count"></span><a cla=
ss=3D"reload-button"
+                  onclick=3D"reloadTable('#oldmilestone');">Reload Bugs<=
/a></h4>
             </span>
           </span>
           <p>
@@ -379,7 +399,8 @@
         <section id=3D"inactivebugs-container" class=3D"table-container"=
>
           <span class=3D"spread">
             <span>
-              <h4>Inactive Bugs<span class=3D"bug-count"></span><a class=
=3D"reload-button" onclick=3D"reloadTable('#inactivebugs');">Reload Bugs<=
/a></h4>
+              <h4>Inactive Bugs<span class=3D"bug-count"></span><a class=
=3D"reload-button"
+                  onclick=3D"reloadTable('#inactivebugs');">Reload Bugs<=
/a></h4>
             </span>
           </span>
           <p>
@@ -391,7 +412,8 @@
         <section id=3D"inactivefeatures-container" class=3D"table-contai=
ner">
           <span class=3D"spread">
             <span>
-              <h4>Inactive Enhancements<span class=3D"bug-count"></span>=
<a class=3D"reload-button" onclick=3D"reloadTable('#inactivefeatures');">=
Reload Bugs</a></h4>
+              <h4>Inactive Enhancements<span class=3D"bug-count"></span>=
<a class=3D"reload-button"
+                  onclick=3D"reloadTable('#inactivefeatures');">Reload B=
ugs</a></h4>
             </span>
           </span>
           <p>
@@ -403,7 +425,8 @@
         <section id=3D"newcomer-container" class=3D"table-container">
           <span class=3D"spread">
             <span>
-              <h4>Potential Newcomer<span class=3D"bug-count"></span><a =
class=3D"reload-button" onclick=3D"reloadTable('#newcomer');">Reload Bugs=
</a></h4>
+              <h4>Potential Newcomer<span class=3D"bug-count"></span><a =
class=3D"reload-button"
+                  onclick=3D"reloadTable('#newcomer');">Reload Bugs</a><=
/h4>
             </span>
           </span>
           <p>
@@ -416,7 +439,8 @@
         <section id=3D"retest-container" class=3D"table-container">
           <span class=3D"spread">
             <span>
-              <h4>Needs Testing<span class=3D"bug-count"></span><a class=
=3D"reload-button" onclick=3D"reloadTable('#retest');">Reload Bugs</a></h=
4>
+              <h4>Needs Testing<span class=3D"bug-count"></span><a class=
=3D"reload-button"
+                  onclick=3D"reloadTable('#retest');">Reload Bugs</a></h=
4>
             </span>
           </span>
           <p>
@@ -457,7 +481,7 @@
     const menu =3D document.querySelector('#table-of-contents')
     const scrollspy =3D VanillaScrollspy({ menu })
     scrollspy.init()
-   =20
+
   </script>
   <script>
     const serverUrl =3D "https://bugzilla.yoctoproject.org";
@@ -488,7 +512,7 @@
       // Appends the bug count to both the section headline and
       // the corresponding navigation item
       const container =3D document.querySelector(selector).closest("sect=
ion")
-      const headline =3D  container.querySelector('.bug-count')
+      const headline =3D container.querySelector('.bug-count')
       headline.innerText =3D `(${bugCount})`
=20
       const anchor =3D `#${container.getAttribute('id')}`
@@ -514,7 +538,7 @@
         const th =3D document.createElement("th")
         tr.appendChild(th).appendChild(document.createElement("span")).a=
ppend(value);
         if (key =3D=3D=3D 'id') {
-            th.setAttribute('data-sort-method', 'number')
+          th.setAttribute('data-sort-method', 'number')
         }
       }
=20
@@ -760,4 +784,4 @@
   </script>
 </body>
=20
-</html>
+</html>
\ No newline at end of file
--=20
2.43.0


