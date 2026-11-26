Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14.1795707255559484607
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Nov 2026 07:34:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@dolcini.it header.s=default header.b=Qlwd7Whm;
 spf=pass (domain: dolcini.it, ip: 217.194.8.81, mailfrom: francesco@dolcini.it)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 4F6741F927;
	Thu, 26 Nov 2026 16:34:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1795707252;
	bh=kd6Gnc3btLyeJTvvA5gnkKi/EGZMTM4AxqOIX7f9IHA=; h=From:To:Subject;
	b=Qlwd7WhmZ1U+Aw7w+EMb2GjTibIEa1uTbGtsNxbHSjX48eKS4MjP0A8n77GVFutol
	 FNptlkNe2ytVpAUCWW+zD5WFEYzG6osSKk4fkjaZeqnRgRormcCLUtFNRC+y2zH+9P
	 YhQSbpVVL1frUWx4EiDMnU/OBTCjof4lL1thos6nZYDqmeq/AlKoLw7SJDT/ASI4gB
	 xZDJQBbjyrfUSNiktI5YYFv2dmJCrWA2sC/DV0RJDxkj4+0k8RWCdG8SvrYoqMlcf8
	 ORN3H87cqoV66nIEY1AmGOGRFoi+crshDU4OBRLYpq8IXCCYCmJQ7LuaV4yUv+oFVZ
	 f8uvpni/xTFRg==
From: Francesco Dolcini <francesco@dolcini.it>
To: yocto-patches@lists.yoctoproject.org
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	Scott Murray <scott.murray@konsulko.com>,
	Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][PATCH] systemd: do not enable efi for tpm2
Date: Thu, 26 Nov 2026 16:34:02 +0100
Message-ID: <20261126153403.143528-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Nov 2026 15:34:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5544
Content-Type: text/plain; charset="utf-8"

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Do not implicitly enable systemd EFI support when tpm2 is enabled in
DISTRO_FEATURES, as this builds and enables bootctl and
systemd-boot-update.service on machines that do not boot through UEFI.

Rely on the existing EFI configuration mechanism in OE-Core which
already enable systemd EFI support when efi is present in
DISTRO_FEATURES.

Fixes: 6eb3098e5788 ("systemd: enable TPM support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
We want to enable TPM2 support on systems that do not use UEFI.
Currently, enabling tpm2 in DISTRO_FEATURES unnecessarily forces
EFI support in systemd.
---
 meta-tpm/recipes-core/systemd/systemd_%.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/=
recipes-core/systemd/systemd_%.bbappend
index 867c11183ae2..0568ab5b0db2 100644
--- a/meta-tpm/recipes-core/systemd/systemd_%.bbappend
+++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
@@ -2,7 +2,7 @@ PACKAGECONFIG:append =3D " ${@bb.utils.contains('DISTRO_F=
EATURES', 'tpm2', 'tpm2',
=20
 # for encrypted filesystems
 PACKAGECONFIG:append =3D " \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'cryptsetup cryptset=
up-plugins efi openssl repart', '', d)} \
+    ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'cryptsetup cryptset=
up-plugins openssl repart', '', d)} \
 "
=20
 # ukify.py and systemd-measure don't work in cross compile environment w=
ithout
--=20
2.47.3

