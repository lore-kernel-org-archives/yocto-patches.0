Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.24411.1712856286837347240
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Apr 2024 10:24:46 -0700
From: "Ross Burton" <ross.burton@arm.com>
Subject: [meta-darwin][PATCH] Move patch submission to yocto-patches@
Date: Thu, 11 Apr 2024 17:24:36 +0000
Message-Id: <20240411172436.4172046-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, ecordonnier@snap.com, dominik@snap.com
List-ID: <yocto-patches.lists.yoctoproject.org>

We're moving patch traffic to yocto-patches@ so that yocto@ can be focuse=
d
on user support.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 README | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 72aa77a..77ffdcc 100644
--- a/README
+++ b/README
@@ -42,10 +42,11 @@ Layer Maintainers: Richard Purdie <richard.purdie@lin=
uxfoundation.org>
                    Dominik Schnitzer <dominik@snap.com>
                    Etienne Cordonnier <ecordonnier@snap.com>
=20
-Please send changes to the yocto mailing list (yocto@lists.yoctoproject.=
org) with [meta-darwin]
-in the subject line, cc'ing the maintainers. You need to subscribe to th=
e mailing list at
-https://lists.yoctoproject.org/g/yocto before being able to post.
+Please send changes to the yocto-patches mailing list
+(yocto-patches@lists.yoctoproject.org) with [meta-darwin] in the subject=
 line,
+cc'ing the maintainers. You need to subscribe to the mailing list at
+https://lists.yoctoproject.org/g/yocto-patches before being able to post=
.
=20
 When sending single patches, please use something like:
-'git send-email -M -1 --to yocto@lists.yoctoproject.org --subject-prefix=
=3D"meta-darwin][PATCH"'
+'git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --subjec=
t-prefix=3D"meta-darwin][PATCH"'
=20
--=20
2.34.1

