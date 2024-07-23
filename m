Return-Path: <mathieu.dupre@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2539EC3DA63
	for <webhook@archiver.kernel.org>; Tue, 23 Jul 2024 16:00:06 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.766.1721750396629146987
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jul 2024 08:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=jt46kT7t;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: mathieu.dupre@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EDB9D9C5D5C
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jul 2024 11:59:55 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id k9Wop-TjExa5 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jul 2024 11:59:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8B2EC9C5E61
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jul 2024 11:59:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8B2EC9C5E61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1721750395; bh=7RdZe/XkEAO47J+YWfHYJzIRCxobhR2PBnPz1p9gpQ0=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=jt46kT7t6oIlnimi5UOz5xgfb2iPPxtLkGmHBB6b3DfOX5MKLRrX9Zg8fxw4Z5ArT
	 nZjzGOIiPzOp+ZR4JomZH0/o6t1eovvPxtnkFmttO1r583qfZg0kH3HcMWzaJs0yuW
	 VK4EZvEei6kqqI6sr90RhIb5YbGh6oATl2JdONi/VP/FtrD1o78GJeM8Vy5rJVnf2v
	 AA3KVTaDqVv7XuxVh2xp99tpsh9H3DkfVra52gE5TPIQw926nu+tpWKT4S/TYaOv0h
	 E2nJWkdfuUDJ1dZ4BJu7VeoxeZvFsOA/83d2otQidVOnvLcPGtVPXKpkPj4AXoS8op
	 NlBpUm65z80VQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id DWco95VIVHvS for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jul 2024 11:59:55 -0400 (EDT)
Received: from jean.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 378889C5E60
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jul 2024 11:59:55 -0400 (EDT)
From: =?UTF-8?q?Mathieu=20Dupr=C3=A9?= <mathieu.dupre@savoirfairelinux.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-cgl][PATCH] pacemaker: remove remote resource agent from pacemaker-remote
Date: Tue, 23 Jul 2024 17:59:45 +0200
Message-Id: <20240723155945.1705212-1-mathieu.dupre@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jul 2024 16:00:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/447

The remote resource agent should be packaged with the other ocf files
in the pacemaker package. This file is not used by pacemaker-remote but
by pacemaker to connect to the remote.

Signed-off-by: Mathieu Dupr=C3=A9 <mathieu.dupre@savoirfairelinux.com>
---
 meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb b/m=
eta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
index c3fdff3..49d741e 100644
--- a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
+++ b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
@@ -111,7 +111,6 @@ FILES:${PN}-cluster-libs =3D "${libdir}/libcrmcluster=
.so.*"
 RDEPENDS:${PN}-cluster-libs +=3D "libqb"
 FILES:${PN}-remote =3D "${sysconfdir}/init.d/pacemaker_remote \
                       ${sbindir}/pacemaker_remoted \
-                      ${libdir}/ocf/resource.d/pacemaker/remote \
                      "
 RDEPENDS:${PN}-remote +=3D "libqb bash"
 FILES:${PN} +=3D " ${datadir}/snmp                             \
--=20
2.34.1


