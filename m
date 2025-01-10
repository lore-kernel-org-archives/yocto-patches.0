Return-Path: <Johann.Mantel@embex.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51071E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 14:36:40 +0000 (UTC)
Subject: [meta-security][scarthgap][PATCH] python3-fail2ban: upgrade 1.0.2 -> 1.1.0
To: yocto-patches@lists.yoctoproject.org
From: "Johann JNML. Mantel" <Johann.Mantel@embex.de>
X-Originating-Location: =?UTF-8?B?RnJlaWJ1cmcgaW0gQnJlaXNnYXUsIEJhZGVuLVfDvHJ0dGVtYmVyZywgREU=?= (213.164.94.174)
X-Originating-Platform: Windows Firefox 133
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 10 Jan 2025 06:36:37 -0800
Message-ID: <L5rx.1736519797304232543.n1ln@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="cDZcfOECMN9wJ1OxnSBh"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jan 2025 14:36:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/976

--cDZcfOECMN9wJ1OxnSBh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Changelog:
https://github.com/fail2ban/fail2ban/blob/1.1.0/ChangeLog
---
...3-fail2ban_1.0.2.bb =3D> python3-fail2ban_1.1.0.bb} | 12 +-----------
1 file changed, 1 insertion(+), 11 deletions(-)
rename dynamic-layers/meta-python/recipes-security/fail2ban/{python3-fail2b=
an_1.0.2.bb =3D> python3-fail2ban_1.1.0.bb} (91%)
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-f=
ail2ban_1.0.2.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/pyt=
hon3-fail2ban_1.1.0.bb
similarity index 91%
rename from dynamic-layers/meta-python/recipes-security/fail2ban/python3-fa=
il2ban_1.0.2.bb
rename to dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail=
2ban_1.1.0.bb
index bf5f87d..b52db23 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban=
_1.0.2.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban=
_1.1.0.bb
@@ -11,7 +11,7 @@ LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Decabc31e90311d=
a843753ba772885d9f"

DEPENDS =3D "python3-native"

-SRCREV =3D "e1d3006b0330e9777705a7baafe3989d442ed120"
+SRCREV =3D "61799e15e1dd4389dea0cc7595da0a287835a177"
SRC_URI =3D "git://github.com/fail2ban/fail2ban.git;branch=3Dmaster;protoco=
l=3Dhttps \
file://initd \
file://run-ptest \
@@ -26,16 +26,6 @@ SYSTEMD_SERVICE:${PN} =3D "fail2ban.service"

S =3D "${WORKDIR}/git"

-do_compile () {
- =C2=A0 =C2=A0cd ${S}
-
- =C2=A0 =C2=A0#remove symlink to python3
- =C2=A0 =C2=A0# otherwise 2to3 is run against it
- =C2=A0 =C2=A0rm -f bin/fail2ban-python
-
- =C2=A0 =C2=A0./fail2ban-2to3
-}
-
do_install:append () {
rm =C2=A0-f ${D}/${bindir}/fail2ban-python
install -d ${D}/${sysconfdir}/fail2ban
--
2.47.1

--cDZcfOECMN9wJ1OxnSBh
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>Changelog:<br />https://github.com/fail2ban/fail2ban/blob/1.1.0/Change=
Log<br />---<br />&nbsp;...3-fail2ban_1.0.2.bb =3D&gt; python3-fail2ban_1.1=
.0.bb} | 12 +-----------<br />&nbsp;1 file changed, 1 insertion(+), 11 dele=
tions(-)<br />&nbsp;rename dynamic-layers/meta-python/recipes-security/fail=
2ban/{python3-fail2ban_1.0.2.bb =3D&gt; python3-fail2ban_1.1.0.bb} (91%)</d=
iv>
<div>diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/pyth=
on3-fail2ban_1.0.2.bb b/dynamic-layers/meta-python/recipes-security/fail2ba=
n/python3-fail2ban_1.1.0.bb<br />similarity index 91%&nbsp;<br />rename fro=
m dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0=
.2.bb<br />rename to dynamic-layers/meta-python/recipes-security/fail2ban/p=
ython3-fail2ban_1.1.0.bb<br />index bf5f87d..b52db23 100644<br />--- a/dyna=
mic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb<=
br />+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fai=
l2ban_1.1.0.bb<br />@@ -11,7 +11,7 @@ LIC_FILES_CHKSUM =3D "file://COPYING;=
md5=3Decabc31e90311da843753ba772885d9f"<br />&nbsp;<br />&nbsp;DEPENDS =3D =
"python3-native"<br />&nbsp;<br />-SRCREV =3D "e1d3006b0330e9777705a7baafe3=
989d442ed120"<br />+SRCREV =3D "61799e15e1dd4389dea0cc7595da0a287835a177"<b=
r />&nbsp;SRC_URI =3D "git://github.com/fail2ban/fail2ban.git;branch=3Dmast=
er;protocol=3Dhttps \<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; file:/=
/initd \<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; file://run-ptest \<=
br />@@ -26,16 +26,6 @@ SYSTEMD_SERVICE:${PN} =3D "fail2ban.service"<br />&=
nbsp;<br />&nbsp;S =3D "${WORKDIR}/git"<br />&nbsp;<br />-do_compile () {<b=
r />- &nbsp; &nbsp;cd ${S}<br />-<br />- &nbsp; &nbsp;#remove symlink to py=
thon3<br />- &nbsp; &nbsp;# otherwise 2to3 is run against it<br />- &nbsp; =
&nbsp;rm -f bin/fail2ban-python<br />-<br />- &nbsp; &nbsp;./fail2ban-2to3<=
br />-}<br />-<br />&nbsp;do_install:append () {<br />&nbsp; &nbsp; &nbsp;r=
m &nbsp;-f ${D}/${bindir}/fail2ban-python<br />&nbsp; &nbsp; &nbsp;install =
-d ${D}/${sysconfdir}/fail2ban<br />--&nbsp;<br />2.47.1</div>
</div>

--cDZcfOECMN9wJ1OxnSBh--

