Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2063FC982D1
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27088.1789597836361401024
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=p1HK6wut;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910a0cefaso13307685a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597835; x=1790202635; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xdlFyYrGKG5jHyZuV87d9EKl7RH3zmWbK3/ikF3Iy8A=;
        b=p1HK6wutlWolGr1+GXuJTvH94CYAdTVvRa01QMKBp9KyXArTMrNmjpys7HBccyt9fK
         431hqI81w5jtYPoefoaiG9fOwUgmxscfgpohvCjP412JXDyJOiK+xgPED/Lx/pvTccvJ
         sgOkoweUrE3YTUQA6wdcnXrmjM/Koryn9kk50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597835; x=1790202635;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xdlFyYrGKG5jHyZuV87d9EKl7RH3zmWbK3/ikF3Iy8A=;
        b=hK/d0cfAu6/YKdkPGaEMutNuRtEsn2+FR+MGOJb7A3ALZSz8YamYzy44n0vC7h9zJ/
         kt6w87ZRoyoPBQBOA5RFw7bP3QlsTJ7xVgeti6OfA3NFjh6NJ3TQyuRDtrIs6TCTB2g7
         F7zcEvCBd9bG7aOeh0b0qcAc9kGiKOjUFL3V4lboGt350egGWhMMW15oBYqZNRFZGb7e
         GTqbm5BwZ5bnaNj1/Ze7ax+hieKBukizrpMVSgMyhqIvaOyARFBM+y8lYFVdAddKxrku
         R3Bu08SMLbcHMgwr2A5X42D2v6yHMFgjbk9qh/PChLZvPF9VlKRB18U2IG/rfv2BUb4J
         AkQg==
X-Gm-Message-State: AFuF++mj5Wk0jd41tyH6+N7AOsOeLBqfhwg98tjM/msFhUio6iqJT5EQ
	yrNO2DSION02agZtFazpg7kPe5zmoa/vIp6n1jkwFNshijcl3+Uj3qOZTafjc91WK8x9BEFmnHu
	8ZY4Y
X-Gm-Gg: AYBFou3oFO+V3fbRy5+H80tVQOas4RuM3fffceZDFwttqM60RbbEWRRyPa6+CFK8s2p
	ymV70dciDqsnQ7iCEGtjjH1iSrjrBv5jCqinZCC14oJEsFGQ1A12CGa9Rti43fyja3eblO/sAQ8
	ef/WDQ9WcxVB4VacY3eUe+PLr9gQZ/MZiW8GpLbn3295jL2MMDhqAaz7sNqpsunbAyj5pn70bL4
	7yt/0vJ/5QKOMR+RVNZkEtTNVXXkzyb5EoSSqFRn+/KLihbA+8FWWw5sHj2Sz4VLS8q+C6RZ+vE
	DlpGjDBTF8hkXMSjfFQXe9IlRrU2uNokNOVKE+AByac/XQKjj5QBSt9omxIOCQlsEo/xIZr1NRR
	f+AvFdqg5qbkqUxi4cOle3AWcVw5hwAKx7LGqySIU+ZYTki2SWgRfHLaTuA1zPK3RjGiqSx3Il0
	GU65TqEdRxifZqlz8nQE425Ru4JjK4HIuE7ymHY4NT3gQpaQhaWgslH9M+of1y002OFpnyrYeF3
	PRqh3cvbkMLYR/4U8GYPhRxvtiESNc3cqh8VGA0n6JoJj6rLitpdWnJ1hXOszUeEmdSsml7NYYX
	5Iv8MfDhgi18sQwZlzshjGB1TkL20lr5ZaM=
X-Received: by 2002:a05:620a:199d:b0:939:3885:3131 with SMTP id af79cd13be357-93bb77087camr701962585a.3.1789597835212;
        Wed, 16 Sep 2026 15:30:35 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:34 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 05/24] wic: document the meta-intel dependency in the dm-verity hash example
Date: Wed, 16 Sep 2026 18:29:59 -0400
Message-ID: <e441952be904b3d1c99195a3e19b84bf9da927df.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4881

From: Gaël PORTAY <gael.portay+rtone@gmail.com>

The dependency might not be obvious to everyone, so leave a hint as in
commit 2fbeebc18c ("dm-verity: document the meta-intel dependency in the
systemd example").

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 files/wic/systemd-bootdisk-dmverity-hash.wks.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/files/wic/systemd-bootdisk-dmverity-hash.wks.in b/files/wic/systemd-bootdisk-dmverity-hash.wks.in
index e400593..67abaa6 100644
--- a/files/wic/systemd-bootdisk-dmverity-hash.wks.in
+++ b/files/wic/systemd-bootdisk-dmverity-hash.wks.in
@@ -6,6 +6,7 @@
 # Based on OE-core's systemd-bootdisk.wks and meta-security's beaglebone-yocto-verity.wks.in file
 #
 # This .wks only works with the dm-verity-img class and separate hash data. (DM_VERITY_SEPARATE_HASH)
+# Also note that the use of microcode.cpio introduces a meta-intel layer dependency.
 
 part /boot --source bootimg-efi --sourceparams="loader=systemd-boot,initrd=microcode.cpio" --ondisk sda --label msdos --active --align 1024 --use-uuid
 
-- 
2.55.0


