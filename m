Return-Path: <alba@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ECAD3F062
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:03:03 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13579.1769608977014107981
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Jan 2026 06:02:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=Cm4SCUYr;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.128.44, mailfrom: alba@thehoodiefirm.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso6331865e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 06:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1769608975; x=1770213775; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7n+5MzBEcZ0m75jilE+qh+9JOajgYDnZG0GfKz4tvgA=;
        b=Cm4SCUYrvMU9q03j8EKYvzFpRgq8Zqs3eVYPHSpULB+GFZcRuISjOkXs0qes3gFew8
         WoIcfvyotBVFju6WIlhjRUMPHXZ09F+4wsQRDKUYimJ6Uwbhd7sEIzog+gvjPAEIVOyf
         gpwle7PUxtTOCpfP20grTw6QGYwUa6HUpD2uz7py7CDDQPfNTZFDTmtfS//F6KhV6WOK
         o946hytdDbVQxNRqawxxvwtDGC+z3Tg91eNmbGbW+rAqt9RTdEisPELvpg6XyZ/scTxE
         utnf5AEkEp8MSYMEu6r1wNSMUYa4GhXsARY8C8/qoRY5TjMKSlqp3J9wYtrh0Wej/EvU
         2zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769608975; x=1770213775;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7n+5MzBEcZ0m75jilE+qh+9JOajgYDnZG0GfKz4tvgA=;
        b=ER0g+qb0eW5DZPclZP5vs4kRQoytz8ANEfAxTB2cF/eMSDgRwjgt2ccdLeJncFi0j3
         8Uy4GVA8zImtUgjo8ZWvqk2aOpvlR5VD79u+mYPGcZNBP+gJ8oqOBp8H21S5Gm1x7zOl
         sbZkdvM39Czbt6AUg7wnukzSfcZ1d1enKoVcBaPs7VlQhyRTJphvuGogoVY+SyIyzGxM
         f9AJOc/JteF+yQKiKRY/jwQvhHsPx97Xo+pOczGjbTQHxjYrcRqqWYO0igdqwhkS59YV
         LAqk6S8yUY2y6CuQg1Y8g61n6UoHJlDbFamThf4eDbXFTJlx/NvtuJEeybbdVBLyCo5f
         K/sQ==
X-Gm-Message-State: AOJu0YwyA2tUMsCkzpMmva3Mf9+TWXrTgm0pTlMZt7WcAnTdS5cCy2jP
	Y1u0Er7nb+4WRPAPjFWxPYc0AD9HMZZ9Z63jhApIjIA76rjcXy2rrztF1lTM3bv8MUz7xS2J1Ak
	s68r5sss=
X-Gm-Gg: AZuq6aJBlQ/2DMltkcJYWbO3sscJGahd7Nq0sO3Yr85+zou76Dt/5oVVq3uRKuaFHQY
	BvA8XzQv0AGXGfL7931JoRwhSFV9ZpUPmY7AF6HUoTbXCHI1vghCdSiAe2GdaAb9nwc5MsGAIfi
	mMHP9C0zY3QG83IgjnArmoWnysHw73o15q4jnv+hLc1DaSpqIkDwdretfC60C1Mvg5yTRVO35sS
	Ir0JuOo1Zs0BXSykDpcVbFKlpfFKZXYja8aL+yfHphRhT1ZodvQh1V0eymS1ZIECVxD9RUTsBm9
	E8mN7kUQWSBBW4ez6gEtXmnelL4LlJs91IUS9MmyyOzUxm3HSqSRDr5+58KS482H3MBDnx1u9kk
	hYpNseUTFa1xxMT0uOer+lktZhLDhXaopWnpnL2/uNpr+pN/jHvNcqVvnMv24un18HI0DRXJGWq
	t9oU39ok09e/bL2yyj0GgFVP+GbEbP1tycfNWsgeixbSyEpEvXwcnU2tuEarAQVJki22S7ZKfSb
	CnOcAsuhPXRO/s=
X-Received: by 2002:a05:600c:3113:b0:480:1c75:407c with SMTP id 5b1f17b1804b1-48069bfaaf6mr69391475e9.2.1769608974859;
        Wed, 28 Jan 2026 06:02:54 -0800 (PST)
Received: from localhost.localdomain (253.red-83-57-139.dynamicip.rima-tde.net. [83.57.139.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd78d3sm68522105e9.1.2026.01.28.06.02.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Jan 2026 06:02:54 -0800 (PST)
Sender: =?UTF-8?B?QWxiYSBIZXJyZXLDrWFzIFJhbcOtcmV6?= <alba@thehoodiefirm.com>
From: Alba Herrerias <alba@neighbourhood.ie>
X-Google-Original-From: Alba Herrerias <albaherreriasdev@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <alex@neighbourhood.ie>
Subject: [yocto-autobuilder-helper][PATCH 3/4] dashboard/bugtriage: update to unify styles with CVE/Patch Metrics pages
Date: Wed, 28 Jan 2026 14:02:06 +0000
Message-Id: <20260128140207.61443-4-albaherreriasdev@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260128140207.61443-1-albaherreriasdev@gmail.com>
References: <20260128140207.61443-1-albaherreriasdev@gmail.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 14:03:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3134

From: Alex Feyerke <alex@neighbourhood.ie>

Replaced Google Material libraries with Pico.css, updated table sorting lib=
rary.

Signed-off-by: Alex Feyerke <alex@neighbourhood.ie>
---
 scripts/dashboard/bugtriage/index.html        | 588 ++++++++++++------
 scripts/dashboard/bugtriage/tablesort.min.js  |   6 +
 .../dashboard/bugtriage/tablesort.number.js   |  26 +
 3 files changed, 447 insertions(+), 173 deletions(-)
 create mode 100644 scripts/dashboard/bugtriage/tablesort.min.js
 create mode 100644 scripts/dashboard/bugtriage/tablesort.number.js

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/bug=
triage/index.html
index 10d998d..82ee3c3 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -5,181 +5,414 @@
   <meta charset=3D"UTF-8">
   <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-scale=
=3D1.0">
   <title>Bug Triage</title>
-  <link href=3D"https://fonts.googleapis.com/icon?family=3DMaterial+Icons"=
 rel=3D"stylesheet">
-  <link rel=3D"stylesheet" href=3D"https://cdnjs.cloudflare.com/ajax/libs/=
materialize/1.0.0/css/materialize.min.css">
+  <link rel=3D"stylesheet" href=3D"../resources/pico.fluid.classless.min.c=
ss">
+  <link rel=3D"stylesheet" href=3D"../resources/shared-styles.css">
+  <link rel=3D"apple-touch-icon" sizes=3D"144x144" href=3D"../resources/ap=
ple-touch-icon.png">
+  <link rel=3D"icon" type=3D"image/png" sizes=3D"32x32" href=3D"../resourc=
es/favicon-32x32.png">
+  <link rel=3D"icon" type=3D"image/png" sizes=3D"16x16" href=3D"../resourc=
es/favicon-16x16.png">
   <style>
-    .pin-top {
-      position: relative;
+    body>main {
+      padding-block-start: 0;
     }
=20
-    .pin-bottom {
-      position: relative;
+    .spread {
+      display: flex;
+      justify-content: space-between;
     }
=20
-    .pinned {
-      position: fixed !important;
+    .content-with-sidebar {
+      display: flex;
+      flex-wrap: nowrap;
+      flex-direction: row-reverse;
     }
=20
-    .table-of-contents a.active {
-      border-left-color: #03a9f4;
+    .content {
+      padding-block-start: 1em;
     }
=20
-    table.sortable th:not(.sorttable_sorted):not(.sorttable_sorted_reverse=
):not(.sorttable_nosort):after {
-      content: " \25B4\25BE"
+    .sidebar {
+      border-left: 1px solid #ddd;
+      width: 20rem;
     }
-  </style>
-</head>
=20
-<body>
-  <nav>
-    <div class=3D"nav-wrapper light-blue" id=3D"nav">
-      <span class=3D"brand-logo">&nbsp;Yocto Project Bug Triage</span>
-      <ul id=3D"nav-mobile" class=3D"right hide-on-med-and-down">
-        <li><a href=3D"https://bugzilla.yoctoproject.org/">Bugzilla</a></l=
i>
-        <li><a href=3D"https://autobuilder.yoctoproject.org/">Autobuilder<=
/a></li>
-      </ul>
-    </div>
-  </nav>
-
-  <div class=3D"row">
-    <div class=3D"col s12 m9 l10">
-      <p>
-        The outcome of the bug triage meeting should be that all bugs have=
 an
-        owner, a target milestone, and a priority.
-      </p>
-      <p>
-        The meeting is held every Thursday at 07:30 Pacific Time (typically
-        15:30 GMT or 16:30 CET, but be aware of daylight saving shifts). T=
he
-        meeting is held on <a href=3D"https://zoom.us/">Zoom</a>, join wit=
h either the <a
-        href=3D"https://zoom.us/j/454367603?pwd=3DZGxoa2ZXL3FkM3Y0bFd5aVpH=
VVZ6dz09">direct
-        link</a> or use the Meeting ID <strong>454-367-603</strong> and pa=
ssword
-        <strong>277925</strong>.
-      </p>
-      <p>
-        The call facilitator is Stephen Jolley &lt;<a
-        href=3D"mailto:sjolley.yp.pm@gmail.com">sjolley.yp.pm@gmail.com</a=
>&gt;. The
-        facilitator's job is to ensure the agenda is kept to, without rath=
oling
-        on any particular bug, and keeping to the time slot.
-      </p>
-
-      <div class=3D"section scrollspy" id=3D"security-container">
-        <h4>Security-related</h4>
-        <p>
-          <a href=3D"https://bugzilla.yoctoproject.org/buglist.cgi?list_id=
=3D604307&resolution=3D---&query_format=3Dadvanced&bug_status=3DUNCONFIRMED=
&bug_status=3DNEW&bug_status=3DACCEPTED&bug_status=3DIN%20PROGRESS%20DESIGN=
&bug_status=3DIN%20PROGRESS%20DESIGN%20COMPLETE&bug_status=3DIN%20PROGRESS%=
20IMPLEMENTATION&bug_status=3DIN%20PROGRESS%20REVIEW&bug_status=3DREOPENED&=
bug_status=3DNEEDINFO&product=3DSecurity&product=3DSecurity%20-%20Recipe%20=
Upgrade" target=3D"_blank">View security-related bugs in Bugzilla</a>.
-        </p>
-        <p>
-          Security issues a need to be viewed directly in Bugzilla as they=
 are
-          only visible to users with sufficient permissions.
-        </p>
-      </div>
+    tr td:nth-child(2) {
+      word-break: break-word;
+    }
=20
-      <div class=3D"section scrollspy" id=3D"unprioritised-container">
-        <h4>Unprioritised <a class=3D"waves-effect btn-flat" onclick=3D"re=
loadTable('#unprioritised');"><i class=3D"material-icons">refresh</i></a></=
h4>
-        <p>
-          Bugs without a priority, that need a priority, target milestone,=
 and owner assigned.
-        </p>
-        <div id=3D"unprioritised"></div>
-      </div>
+    #table-of-contents {
+      position: fixed;
+      margin: 0.5em 1em;
+    }
=20
-      <div class=3D"section scrollspy" id=3D"high-container">
-        <h4>High <a class=3D"waves-effect btn-flat" onclick=3D"reloadTable=
('#high');"><i class=3D"material-icons">refresh</i></a></h4>
-        <p>
-          All open high-priority bugs.
-        </p>
-        <div id=3D"high"></div>
-      </div>
+    #table-of-contents ul {
+      padding: 0;
+      margin: 0.5em;
+    }
=20
-      <div class=3D"section scrollspy" id=3D"reopened-container">
-        <h4>Reopened <a class=3D"waves-effect btn-flat" onclick=3D"reloadT=
able('#reopened');"><i class=3D"material-icons">refresh</i></a></h4>
-        <p>
-          Bugs that have been reopened. The owner should be reviewed and t=
he bug
-          moved to another state.
-        </p>
-        <div id=3D"reopened"></div>
-      </div>
+    #table-of-contents li {
+      list-style: none;
+    }
=20
-      <div class=3D"section scrollspy" id=3D"abint-container">
-        <h4>Autobuilder Intermittent <a class=3D"waves-effect btn-flat" on=
click=3D"reloadTable('#abint');"><i class=3D"material-icons">refresh</i></a=
></h4>
-        <p>
-          Bugs which are tagged as tracking intermittent failures on the
-          autobuilder. A <a
-          href=3D"https://valkyrie.yocto.io/pub/non-release/abint/" target=
=3D"_blank">graphical
-          view</a> is also available.
-        </p>
-        <div id=3D"abint"></div>
-      </div>
+    #table-of-contents a {
+      text-decoration: none;
+      padding-inline-start: 0.5em;
+      border-left: 5px solid transparent;
+    }
=20
-      <div class=3D"section scrollspy" id=3D"needinfo-container">
-        <h4>Need Info <a class=3D"waves-effect btn-flat" onclick=3D"reload=
Table('#needinfo');"><i class=3D"material-icons">refresh</i></a></h4>
-        <p>
-          All bugs that are in the NEEDINFO state, and should be reviewed =
to
-          identify if the information has been provided and the bug should=
 be
-          moved to another state.
-        </p>
-        <div id=3D"needinfo"></div>
-      </div>
+    #table-of-contents a.active {
+      font-weight: bold;
+      border-left-color: var(--pico-primary);
+    }
=20
-      <div class=3D"section scrollspy" id=3D"inactivebugs-container">
-        <h4>Inactive Bugs <a class=3D"waves-effect btn-flat" onclick=3D"re=
loadTable('#inactivebugs');"><i class=3D"material-icons">refresh</i></a></h=
4>
-        <p>
-          All open bugs that haven't been altered in two years.
-        </p>
-        <div id=3D"inactivebugs"></div>
-      </div>
+    .bug-count {
+      padding-inline: 0.25em;
+    }
=20
-      <div class=3D"section scrollspy" id=3D"inactivefeatures-container">
-        <h4>Inactive Enhancements <a class=3D"waves-effect btn-flat" oncli=
ck=3D"reloadTable('#inactivefeatures');"><i class=3D"material-icons">refres=
h</i></a></h4>
-        <p>
-          All open enhancements that haven't been altered in two years.
-        </p>
-        <div id=3D"inactivefeatures"></div>
-      </div>
+    .reload-button {
+      cursor: pointer;
+      text-decoration: none;
+      font-size: 0;
+    }
=20
-      <div class=3D"section scrollspy" id=3D"oldmilestone-container">
-        <h4>Wrong Milestone <a class=3D"waves-effect btn-flat" onclick=3D"=
reloadTable('#oldmilestone');"><i class=3D"material-icons">refresh</i></a><=
/h4>
-        <p>
-          All open bugs that are targetted for a milestone in the past: th=
ey
-          should be closed if fixed, or moved to a future milestone.
-        </p>
-        <div id=3D"oldmilestone"></div>
-      </div>
+    .reload-button::after {
+      content: "=E2=86=BB";
+      font-size: 1.25rem;
+    }
=20
-      <div class=3D"section scrollspy" id=3D"newcomer-container">
-        <h4>Potential Newcomer <a class=3D"waves-effect btn-flat" onclick=
=3D"reloadTable('#newcomer');"><i class=3D"material-icons">refresh</i></a><=
/h4>
-        <p>
-          All open bugs which have been tagged as being potentially good f=
or
-          newcomers to the project who want to make their first contributi=
on.
-        </p>
-        <div id=3D"newcomer"></div>
-      </div>
+    [href=3D"#top"] {
+      cursor: pointer;
+      text-decoration: none;
+      font-size: 1em;
+      padding-inline-end: 1em;
+    }
+
+    .table-container {
+      overflow-x: auto;
+      margin-inline-end: 0;
+      max-width: calc(100vw - 20rem);
+    }
+
+    th {
+      cursor: pointer;
+    }
+
+    th span {
+      display: flex;
+      flex-direction: row;
+      flex-wrap: nowrap;
+      align-items: center;
+      gap: 0.5em;
+    }
+
+    th span:after {
+      content: "=E2=8F=B6=E2=8F=B7";
+      color: #111;
+      opacity: 0.25;
+    }
+=20=20=20=20
+    @media (prefers-color-scheme: dark) {
+      th span:after {
+        color: #EEE;
+      }
+    }
+
+    th[aria-sort=3D"ascending"] span:after {
+      content: "=E2=8F=B6";
+      opacity: 1;
+    }
+=20=20=20=20
+    th[aria-sort=3D"descending"] span:after {
+      content: "=E2=8F=B7";
+      opacity: 1;
+    }
+
+    #nav-drawer-open,=20
+    #nav-drawer-close {
+      display: none;
+      cursor: pointer;
+      font-size: 2.5rem;
+      line-height: 0.9em;
+    }=20
=20
-      <div class=3D"section scrollspy" id=3D"retest-container">
-        <h4>Needs Testing <a class=3D"waves-effect btn-flat" onclick=3D"re=
loadTable('#retest');"><i class=3D"material-icons">refresh</i></a></h4>
-        <p>
-          All open bugs which have been tagged as needing to be retested.
-        </p>
-        <div id=3D"retest"></div>
+    #nav-drawer-open {
+      margin-inline-end: 0.75em;
+    }
+
+    #nav-drawer-close {
+      width: 100%;
+      text-align: right;
+      margin-top: 0.35em;
+      padding-inline-end: 0.4em;
+    }
+=20=20=20=20
+    @media (max-width: 1024px) {
+      body>main {
+        padding-right: 0;
+      }
+      #nav-drawer-open,=20
+      #nav-drawer-close {
+        display: block;
+      }=20
+      .spread {
+        display: flex;
+        justify-content: space-between;
+        position: sticky;
+      }
+      body.show-nav .sidebar{
+        transform: translateX(0em);
+      }
+      .sidebar {
+        display: block;
+        position: fixed;
+        background: white;
+        height: 100vh;
+        z-index: 1;
+        transform: translateX(22em);
+        width: auto;
+        transition: all 0.5s;
+        overflow-y: auto;
+      }
+      #table-of-contents {
+        position: relative;
+        margin-bottom: 2em;
+      }
+      section {
+        margin-inline: 0;
+      }
+      .table-container {
+        max-width: 95vw;
+      }
+    }
+  </style>
+</head>
+
+<body>
+  <main>
+    <div class=3D"content-with-sidebar">
+      <div class=3D"sidebar">
+        <div id=3D"table-of-contents">
+          <div id=3D"nav-drawer-close">=C3=97</div>
+          <ul>
+            <li>Navigation:</li>
+            <li><a href=3D"/">Yocto Dashboard</a></li>
+            <li><a href=3D"https://bugzilla.yoctoproject.org/">Bugzilla</a=
></li>
+            <li><a href=3D"https://autobuilder.yoctoproject.org/">Autobuil=
der</a></li>
+            <li>Bug Categories:</li>
+            <li><a href=3D"#security-container">Security<span class=3D"bug=
-count"></span></a></li>
+            <li><a href=3D"#unprioritised-container">Unprioritised<span cl=
ass=3D"bug-count"></span></a></li>
+            <li><a href=3D"#high-container">High<span class=3D"bug-count">=
</span></a></li>
+            <li><a href=3D"#reopened-container">Reopened<span class=3D"bug=
-count"></span></a></li>
+            <li><a href=3D"#abint-container">AB-INT<span class=3D"bug-coun=
t"></span></a></li>
+            <li><a href=3D"#needinfo-container">Need Info<span class=3D"bu=
g-count"></span></a></li>
+            <li><a href=3D"#inactivebugs-container">Old Bugs<span class=3D=
"bug-count"></span></a></li>
+            <li><a href=3D"#inactivefeatures-container">Old Features<span =
class=3D"bug-count"></span></a></li>
+            <li><a href=3D"#oldmilestone-container">Wrong Milestone<span c=
lass=3D"bug-count"></span></a></li>
+            <li><a href=3D"#newcomer-container">Newcomer<span class=3D"bug=
-count"></span></a></li>
+            <li><a href=3D"#retest-container">Retest<span class=3D"bug-cou=
nt"></span></a></li>
+          </ul>
+        </div>
+      </div>
+      <div class=3D"content">
+        <div class=3D"spread">
+          <h1 id=3D"top" class=3D"with-logo">Yocto Project Bug Triage</h1>
+          <div id=3D"nav-drawer-open">=E2=89=A1</div>
+        </div>
+        <section>
+          <p>
+            The outcome of the bug triage meeting should be that all bugs =
have an
+            owner, a target milestone, and a priority.
+          </p>
+          <p>
+            The meeting is held every Thursday at 07:30 Pacific Time (typi=
cally
+            15:30 GMT or 16:30 CET, but be aware of daylight saving shifts=
). The
+            meeting is held on <a href=3D"https://zoom.us/">Zoom</a>, join=
 with either the <a href=3D"https://zoom.us/j/454367603?pwd=3DZGxoa2ZXL3FkM=
3Y0bFd5aVpHVVZ6dz09">direct
+              link</a> or use the Meeting ID <strong>454-367-603</strong> =
and password
+            <strong>277925</strong>.
+          </p>
+          <p>
+            The call facilitator is Stephen Jolley &lt;<a href=3D"mailto:s=
jolley.yp.pm@gmail.com">sjolley.yp.pm@gmail.com</a>&gt;. The
+            facilitator's job is to ensure the agenda is kept to, without =
ratholing
+            on any particular bug, and keeping to the time slot.
+          </p>
+        </section>
+        <section id=3D"security-container" class=3D"table-container">
+          <h4>Security-related</h4>
+          <p>
+            <a href=3D"https://bugzilla.yoctoproject.org/buglist.cgi?list_=
id=3D604307&resolution=3D---&query_format=3Dadvanced&bug_status=3DUNCONFIRM=
ED&bug_status=3DNEW&bug_status=3DACCEPTED&bug_status=3DIN%20PROGRESS%20DESI=
GN&bug_status=3DIN%20PROGRESS%20DESIGN%20COMPLETE&bug_status=3DIN%20PROGRES=
S%20IMPLEMENTATION&bug_status=3DIN%20PROGRESS%20REVIEW&bug_status=3DREOPENE=
D&bug_status=3DNEEDINFO&product=3DSecurity&product=3DSecurity%20-%20Recipe%=
20Upgrade" target=3D"_blank">View security-related bugs in Bugzilla</a>.
+          </p>
+          <p>
+            Security issues a need to be viewed directly in Bugzilla as th=
ey are
+            only visible to users with sufficient permissions.
+          </p>
+        </section>
+=20=20=20=20=20=20=20=20
+        <section id=3D"unprioritised-container" class=3D"table-container">
+          <span class=3D"spread">
+            <span>
+              <h4>Unprioritised<span class=3D"bug-count"></span><a class=
=3D"reload-button" onclick=3D"reloadTable('#unprioritised');">Reload Bugs</=
a></h4>
+            </span>
+            <a href=3D"#top">Back to top =E2=8F=B6</a>
+          </span>
+          <p>
+            Bugs without a priority, that need a priority, target mileston=
e, and owner assigned.
+          </p>
+          <div id=3D"unprioritised"></div>
+        </section>
+
+        <section id=3D"high-container" class=3D"table-container">
+          <span class=3D"spread">
+            <span>
+              <h4>High<span class=3D"bug-count"></span><a class=3D"reload-=
button" onclick=3D"reloadTable('#high');">Reload Bugs</a></h4>
+            </span>
+            <a href=3D"#top">Back to top =E2=8F=B6</a>
+          </span>
+          <p>
+            All open high-priority bugs.
+          </p>
+          <div id=3D"high"></div>
+        </section>
+
+        <section id=3D"reopened-container" class=3D"table-container">
+          <span class=3D"spread">
+            <span>
+              <h4>Reopened<span class=3D"bug-count"></span><a class=3D"rel=
oad-button" onclick=3D"reloadTable('#reopened');">Reload Bugs</a></h4>
+            </span>
+            <a href=3D"#top">Back to top =E2=8F=B6</a>
+          </span>
+          <p>
+            Bugs that have been reopened. The owner should be reviewed and=
 the bug
+            moved to another state.
+          </p>
+          <div id=3D"reopened"></div>
+        </section>
+
+        <section id=3D"abint-container" class=3D"table-container">
+          <span class=3D"spread">
+            <span>
+              <h4>Autobuilder Intermittent<span class=3D"bug-count"></span=
><a class=3D"reload-button" onclick=3D"reloadTable('#abint');">Reload Bugs<=
/a></h4>
+            </span>
+            <a href=3D"#top">Back to top =E2=8F=B6</a>
+          </span>
+          <p>
+            Bugs which are tagged as tracking intermittent failures on the
+            autobuilder. A <a href=3D"https://valkyrie.yocto.io/pub/non-re=
lease/abint/" target=3D"_blank">graphical
+              view</a> is also available.
+          </p>
+          <div id=3D"abint"></div>
+        </section>
+
+        <section id=3D"needinfo-container" class=3D"table-container">
+          <span class=3D"spread">
+            <span>
+              <h4>Need Info<span class=3D"bug-count"></span><a class=3D"re=
load-button" onclick=3D"reloadTable('#needinfo');">Reload Bugs</a></h4>
+            </span>
+            <a href=3D"#top">Back to top =E2=8F=B6</a>
+          </span>
+          <p>
+            All bugs that are in the NEEDINFO state, and should be reviewe=
d to
+            identify if the information has been provided and the bug shou=
ld be
+            moved to another state.
+          </p>
+          <div id=3D"needinfo"></div>
+        </section>
+
+        <section id=3D"inactivebugs-container" class=3D"table-container">
+          <span class=3D"spread">
+            <span>
+              <h4>Inactive Bugs<span class=3D"bug-count"></span><a class=
=3D"reload-button" onclick=3D"reloadTable('#inactivebugs');">Reload Bugs</a=
></h4>
+            </span>
+            <a href=3D"#top">Back to top =E2=8F=B6</a>
+          </span>
+          <p>
+            All open bugs that haven't been altered in two years.
+          </p>
+          <div id=3D"inactivebugs"></div>
+        </section>
+
+        <section id=3D"inactivefeatures-container" class=3D"table-containe=
r">
+          <span class=3D"spread">
+            <span>
+              <h4>Inactive Enhancements<span class=3D"bug-count"></span><a=
 class=3D"reload-button" onclick=3D"reloadTable('#inactivefeatures');">Relo=
ad Bugs</a></h4>
+            </span>
+            <a href=3D"#top">Back to top =E2=8F=B6</a>
+          </span>
+          <p>
+            All open enhancements that haven't been altered in two years.
+          </p>
+          <div id=3D"inactivefeatures"></div>
+        </section>
+
+        <section id=3D"oldmilestone-container" class=3D"table-container">
+          <span class=3D"spread">
+            <span>
+              <h4>Wrong Milestone<span class=3D"bug-count"></span><a class=
=3D"reload-button" onclick=3D"reloadTable('#oldmilestone');">Reload Bugs</a=
></h4>
+            </span>
+            <a href=3D"#top">Back to top =E2=8F=B6</a>
+          </span>
+          <p>
+            All open bugs that are targetted for a milestone in the past: =
they
+            should be closed if fixed, or moved to a future milestone.
+          </p>
+          <div id=3D"oldmilestone"></div>
+        </section>
+
+        <section id=3D"newcomer-container" class=3D"table-container">
+          <span class=3D"spread">
+            <span>
+              <h4>Potential Newcomer<span class=3D"bug-count"></span><a cl=
ass=3D"reload-button" onclick=3D"reloadTable('#newcomer');">Reload Bugs</a>=
</h4>
+            </span>
+            <a href=3D"#top">Back to top =E2=8F=B6</a>
+          </span>
+          <p>
+            All open bugs which have been tagged as being potentially good=
 for
+            newcomers to the project who want to make their first contribu=
tion.
+          </p>
+          <div id=3D"newcomer"></div>
+        </section>
+
+        <section id=3D"retest-container" class=3D"table-container">
+          <span class=3D"spread">
+            <span>
+              <h4>Needs Testing<span class=3D"bug-count"></span><a class=
=3D"reload-button" onclick=3D"reloadTable('#retest');">Reload Bugs</a></h4>
+            </span>
+            <a href=3D"#top">Back to top =E2=8F=B6</a>
+          </span>
+          <p>
+            All open bugs which have been tagged as needing to be retested.
+          </p>
+          <div id=3D"retest"></div>
+        </section>
       </div>
     </div>
=20
-    <div class=3D"col hide-on-small-only m3 l2">
-      <ul class=3D"section table-of-contents pushpin">
-        <li><a href=3D"#security-container">Security</a></li>
-        <li><a href=3D"#unprioritised-container">Unprioritised</a></li>
-        <li><a href=3D"#high-container">High</a></li>
-        <li><a href=3D"#reopened-container">Reopened</a></li>
-        <li><a href=3D"#abint-container">AB-INT</a></li>
-        <li><a href=3D"#needinfo-container">Need Info</a></li>
-        <li><a href=3D"#inactivebugs-container">Old Bugs</a></li>
-        <li><a href=3D"#inactivefeatures-container">Old Features</a></li>
-        <li><a href=3D"#oldmilestone-container">Wrong Milestone</a></li>
-        <li><a href=3D"#newcomer-container">Newcomer</a></li>
-        <li><a href=3D"#retest-container">Retest</a></li>
-      </ul>
-    </div>
-  </div>
-  </div>
-  <script src=3D"sorttable.js"></script>
+  </main>
+  <script src=3D"tablesort.min.js"></script>
+  <script src=3D"tablesort.number.js"></script>
+  <script type=3D"text/javascript">
+    // highlight nav items
+    navigation.addEventListener("navigate", (event) =3D> {
+      // Unhighlight any highlighted link
+      document.querySelector('a.active')?.classList.remove("active");
+      // If we=E2=80=99ve navigated to an anchor, highlight the correspond=
ing link(s)
+      const url =3D new URL(event.destination.url);
+      if (url.hash) {
+        document.querySelector(`[href=3D"${url.hash}"]`)?.classList.add("a=
ctive");
+      }
+    })
+  </script>
+  <script type=3D"text/javascript">
+    // Handle toggle of nav drawer
+    document.querySelector('#nav-drawer-open').addEventListener('click', (=
event) =3D> {
+      const body =3D document.querySelector('body')
+      body.classList.toggle('show-nav')
+    })
+
+    document.querySelector('#nav-drawer-close').addEventListener('click', =
(event) =3D> {
+      const body =3D document.querySelector('body')
+      body.classList.toggle('show-nav')
+    })
+=20=20=20=20
+  </script>
   <script>
     const serverUrl =3D "https://bugzilla.yoctoproject.org";
=20
@@ -200,21 +433,37 @@
       ["assigned_to", "Owner"],
     ]);
=20
+    function appendBugCount(selector, bugCount) {
+      // Appends the bug count to both the section headline and
+      // the corresponding navigation item
+      const container =3D document.querySelector(selector).closest("sectio=
n")
+      const headline =3D  container.querySelector('.bug-count')
+      headline.innerText =3D `(${bugCount})`
+
+      const anchor =3D `#${container.getAttribute('id')}`
+      const navLink =3D document.querySelector(`[href=3D"${anchor}"] .bug-=
count`)
+      navLink.innerText =3D `(${bugCount})`
+    }
+
     function populateTable(selector, bugs) {
       if (bugs.length =3D=3D=3D 0) {
         const p =3D document.createElement("p");
         p.innerHTML =3D "<em>No bugs found</em>.";
         document.querySelector(selector).replaceChildren(p);
+        appendBugCount(selector, 0)
         return;
       }
=20
       const table =3D document.createElement("table");
-      table.setAttribute("class", "highlight sortable")
=20
       const header =3D table.appendChild(document.createElement("thead"));
       const tr =3D header.appendChild(document.createElement("tr"));
-      for (const value of fields.values()) {
-        tr.appendChild(document.createElement("th")).append(value);
+      for (const [key, value] of fields.entries()) {
+        const th =3D document.createElement("th")
+        tr.appendChild(th).appendChild(document.createElement("span")).app=
end(value);
+        if (key =3D=3D=3D 'id') {
+            th.setAttribute('data-sort-method', 'number')
+        }
       }
=20
       const body =3D table.appendChild(document.createElement("tbody"));
@@ -230,18 +479,21 @@
       }
=20
       const footer =3D table.appendChild(document.createElement("tfoot"));
-      footer.innerHTML =3D `<tr><td colspan=3D"${fields.size}">${bugs.leng=
th} bugs found.</td></tr>`;
+      footer.innerHTML =3D `<tr><td colspan=3D"${fields.size}">${bugs.leng=
th} bug${bugs.length > 1 ? 's' : ''} found</td></tr>`;
=20
-      sorttable.makeSortable(table);
+      appendBugCount(selector, bugs.length)
+
+      new Tablesort(table);
=20
       document.querySelector(selector).replaceChildren(table);
     }
=20
     async function searchBugs(selector, params) {
-      const spinner =3D document.createElement("div");
-      spinner.setAttribute("class", "progress")
-      spinner.innerHTML =3D `<div class=3D"indeterminate"></div>`;
-      document.querySelector(selector).replaceChildren(spinner);
+      // Refresh a section
+      const table =3D document.querySelector(selector)
+      table.setAttribute('aria-busy', true)
+      const container =3D document.querySelector(selector).closest("sectio=
n")
+      const reloadButton =3D container.querySelector('.reload-button')
=20
       try {
         params.append("include_fields", Array.from(fields.keys()).join());
@@ -260,6 +512,7 @@
         console.error(`Failed to fetch bugs for ${selector}: ${error}`);
         alert("Error fetching bugs. Check the console for details.");
       }
+      table.setAttribute('aria-busy', false)
     }
=20
     async function bugsByWhiteboard(table, keyword) {
@@ -373,12 +626,10 @@
=20
           // The next major release (eg 6.0) is active
           parts =3D release.series_version.split(".");
-          next =3D `${parseInt(parts[0])+1}.0`
+          next =3D `${parseInt(parts[0]) + 1}.0`
           active.push(next);
           // And all of the next releases milestones
           active.push(...createMilestones(next));
-
-          console.log(active);
         }
       }
       return active;
@@ -441,16 +692,7 @@
     reloadTable("#inactivefeatures");
     reloadTable("#oldmilestone");
     reloadTable("#retest");
-
-    document.addEventListener('DOMContentLoaded', function () {
-      var elems =3D document.querySelectorAll('.scrollspy');
-      M.ScrollSpy.init(elems, { scrollOffset: 100 });
-
-      elems =3D document.querySelectorAll('.pushpin');
-      M.Pushpin.init(elems, { offset: document.querySelector("#nav").offse=
tHeight });
-    });
   </script>
-  <script src=3D"https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/=
js/materialize.min.js"></script>
 </body>
=20
-</html>
+</html>
\ No newline at end of file
diff --git a/scripts/dashboard/bugtriage/tablesort.min.js b/scripts/dashboa=
rd/bugtriage/tablesort.min.js
new file mode 100644
index 0000000..e745bef
--- /dev/null
+++ b/scripts/dashboard/bugtriage/tablesort.min.js
@@ -0,0 +1,6 @@
+/*!
+ * tablesort v5.7.0 (2025-12-26)
+ * http://tristen.ca/tablesort/demo/
+ * Copyright (c) 2025 ; Licensed MIT
+*/
+(()=3D>{function r(t,e){if(!(this instanceof r))return new r(t,e);if(!t||"=
TABLE"!=3D=3Dt.tagName)throw new Error("Element must be a table");this.init=
(t,e||{})}function v(t){var e;return window.CustomEvent&&"function"=3D=3Dty=
peof window.CustomEvent?e=3Dnew CustomEvent(t):(e=3Ddocument.createEvent("C=
ustomEvent")).initCustomEvent(t,!1,!1,void 0),e}function p(t,e){return e=3D=
e.sortAttribute||"data-sort",t.hasAttribute(e)?t.getAttribute(e):t.textCont=
ent||t.innerText||""}function A(t,e){return(t=3Dt.trim().toLowerCase())=3D=
=3D=3D(e=3De.trim().toLowerCase())?0:t<e?1:-1}function E(t,e){return[].slic=
e.call(t).find(function(t){return t.getAttribute("data-sort-column-key")=3D=
=3D=3De})}function x(n,o){return function(t,e){var r=3Dn(t.td,e.td);return =
0=3D=3D=3Dr?o?e.index-t.index:t.index-e.index:r}}var y=3D[];r.extend=3Dfunc=
tion(t,e,r){if("function"!=3Dtypeof e||"function"!=3Dtypeof r)throw new Err=
or("Pattern and sort must be a function");y.push({name:t,pattern:e,sort:r})=
},r.prototype=3D{init:function(t,e){var r,n,o,i=3Dthis;if(i.table=3Dt,i.the=
ad=3D!1,i.options=3De,t.rows&&0<t.rows.length)if(t.tHead&&0<t.tHead.rows.le=
ngth){for(a=3D0;a<t.tHead.rows.length;a++)if("thead"=3D=3D=3Dt.tHead.rows[a=
].getAttribute("data-sort-method")){r=3Dt.tHead.rows[a];break}r=3Dr||t.tHea=
d.rows[t.tHead.rows.length-1],i.thead=3D!0}else r=3Dt.rows[0];if(r){for(var=
 s=3Dfunction(){i.current&&i.current!=3D=3Dthis&&i.current.removeAttribute(=
"aria-sort"),i.current=3Dthis,i.sortTable(this)},a=3D0;a<r.cells.length;a++=
)(o=3Dr.cells[a]).setAttribute("role","columnheader"),"none"!=3D=3Do.getAtt=
ribute("data-sort-method")&&(o.tabIndex=3D0,o.addEventListener("click",s,!1=
),o.addEventListener("keydown",function(t){"Enter"=3D=3D=3Dt.key&&(t.preven=
tDefault(),s.call(this))}),null!=3D=3Do.getAttribute("data-sort-default"))&=
&(n=3Do);n&&(i.current=3Dn,i.sortTable(n))}},sortTable:function(t,e){var r=
=3Dthis,n=3Dt.getAttribute("data-sort-column-key"),o=3Dt.cellIndex,i=3DA,s=
=3D"",a=3D[],d=3Dr.thead?0:1,u=3Dt.getAttribute("data-sort-method"),l=3Dt.h=
asAttribute("data-sort-reverse"),c=3Dt.getAttribute("aria-sort");if(r.table=
.dispatchEvent(v("beforeSort")),e||(c=3D"ascending"=3D=3D=3Dc||"descending"=
!=3D=3Dc&&!!r.options.descending!=3Dl?"descending":"ascending",t.setAttribu=
te("aria-sort",c)),!(r.table.rows.length<2)){if(!u){for(;a.length<3&&d<r.ta=
ble.tBodies[0].rows.length;)0<(s=3D(s=3D(h=3Dn?E(r.table.tBodies[0].rows[d]=
.cells,n):r.table.tBodies[0].rows[d].cells[o])?p(h,r.options):"").trim()).l=
ength&&a.push(s),d++;if(!a)return}for(d=3D0;d<y.length;d++)if(s=3Dy[d],u){i=
f(s.name=3D=3D=3Du){i=3Ds.sort;break}}else if(a.every(s.pattern)){i=3Ds.sor=
t;break}for(r.col=3Do,d=3D0;d<r.table.tBodies.length;d++){var f,h,b=3D[],w=
=3D{},g=3D0,m=3D0;if(!(r.table.tBodies[d].rows.length<2)){for(f=3D0;f<r.tab=
le.tBodies[d].rows.length;f++)"none"=3D=3D=3D(s=3Dr.table.tBodies[d].rows[f=
]).getAttribute("data-sort-method")?w[g]=3Ds:(h=3Dn?E(s.cells,n):s.cells[r.=
col],b.push({tr:s,td:h?p(h,r.options):"",index:g})),g++;for("descending"=3D=
=3D=3Dc?b.sort(x(i,!0)):(b.sort(x(i,!1)),b.reverse()),f=3D0;f<g;f++)w[f]?(s=
=3Dw[f],m++):s=3Db[f-m].tr,r.table.tBodies[d].appendChild(s)}}r.table.dispa=
tchEvent(v("afterSort"))}},refresh:function(){void 0!=3D=3Dthis.current&&th=
is.sortTable(this.current,!0)}},"undefined"!=3Dtypeof module&&module.export=
s?module.exports=3Dr:window.Tablesort=3Dr})();
\ No newline at end of file
diff --git a/scripts/dashboard/bugtriage/tablesort.number.js b/scripts/dash=
board/bugtriage/tablesort.number.js
new file mode 100644
index 0000000..55ece40
--- /dev/null
+++ b/scripts/dashboard/bugtriage/tablesort.number.js
@@ -0,0 +1,26 @@
+(function(){
+  var cleanNumber =3D function(i) {
+    return i.replace(/[^\-?0-9.]/g, '');
+  },
+
+  compareNumber =3D function(a, b) {
+    a =3D parseFloat(a);
+    b =3D parseFloat(b);
+
+    a =3D isNaN(a) ? 0 : a;
+    b =3D isNaN(b) ? 0 : b;
+
+    return a - b;
+  };
+
+  Tablesort.extend('number', function(item) {
+    return item.match(/^[-+]?[=C2=A3\x24=C3=9B=C2=A2=C2=B4=E2=82=AC]?\d+\s=
*([,\.]\d{0,2})/) || // Prefixed currency
+      item.match(/^[-+]?\d+\s*([,\.]\d{0,2})?[=C2=A3\x24=C3=9B=C2=A2=C2=B4=
=E2=82=AC]/) || // Suffixed currency
+      item.match(/^[-+]?(\d)*-?([,\.]){0,1}-?(\d)+([E,e][\-+][\d]+)?%?$/);=
 // Number
+  }, function(a, b) {
+    a =3D cleanNumber(a);
+    b =3D cleanNumber(b);
+
+    return compareNumber(b, a);
+  });
+}());
--=20
2.40.1


