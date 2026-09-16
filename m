Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748E2C88E77
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 02:39:36 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6399.1789526373038394706
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Sep 2026 19:39:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wDHoSouAapq8xoCAA--.1275S3;
	Wed, 16 Sep 2026 10:38:39 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowADHR2jgAKpqQPwyAA--.30913S2;
	Wed, 16 Sep 2026 10:37:21 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH] policycoreutils: fix egrep regression warning
Date: Wed, 16 Sep 2026 10:39:24 +0800
Message-ID: <20260916023924.429106-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowADHR2jgAKpqQPwyAA--.30913S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYMCmqpSYUNnAAAsc
X-CM-DELIVERINFO: =?B?SJb8F5MTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ3KSwAYM2Ck2shLWqtE7
	j2j+61RIEmrf8ngNFtk8syw6QJq4shtRPEggO11U/7xKPWtPu4nlIVIJ+Q05EfZsVYN/kB
	KB8ZAzgklM3wre4g7IomS74D+UDqufPXII4jYT01
X-Coremail-Antispam: 1Uk129KBj93XoWxCryUKw15ZFWxAFyxAFyfKrX_yoW5WF4UpF
	WfKr13Jr4xJF1xJwsFkF42qFyrK3s5KrWkWay3Xa1xCr95ZF18tw4xtF13uFykZr12yayF
	qwsIq3s3G340yagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYS7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
	YxBIdaVFxhVjvjDU0xZFpf9x07j089NUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 02:39:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4854

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Command and output are as below:
```
root@qemuarm64:~# fixfiles check /etc/
egrep: warning: egrep is obsolescent; using grep -E
egrep: warning: egrep is obsolescent; using grep -E
egrep: warning: egrep is obsolescent; using grep -E
egrep: warning: egrep is obsolescent; using grep -E
```

In fact, the egrep issue had been fixed upstream since 2022[1].
The egrep warning was introduced by the local patch. Fix to use
'grep -E' in the local patch to avoid the runtime deprecation warning.

[1] https://github.com/SELinuxProject/selinux/commit/df31981d635d421d304ee10beb7f19bfa36dd385

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 .../policycoreutils-fixfiles-de-bashify.patch      | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/recipes-security/selinux/policycoreutils/policycoreutils-fixfiles-de-bashify.patch b/recipes-security/selinux/policycoreutils/policycoreutils-fixfiles-de-bashify.patch
index 9b94353..3394227 100644
--- a/recipes-security/selinux/policycoreutils/policycoreutils-fixfiles-de-bashify.patch
+++ b/recipes-security/selinux/policycoreutils/policycoreutils-fixfiles-de-bashify.patch
@@ -1,4 +1,4 @@
-From c0675c5dc7e59b345cbd62fd134ef950f3474c22 Mon Sep 17 00:00:00 2001
+From 42d591004563de3ecf8212423932b955c9f4cef8 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 20 Feb 2015 17:00:19 -0500
 Subject: [PATCH] fixfiles: de-bashify
@@ -14,12 +14,15 @@ Upstream-Status: Inappropriate [embedded specific]
 
 Signed-off-by: Joe MacDonald <joe_macdonald@mentor.com>
 Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
+
+[Fix the egrep deprecation issue.]
+Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
 ---
  policycoreutils/scripts/fixfiles | 23 ++++++++++++++---------
  1 file changed, 14 insertions(+), 9 deletions(-)
 
 diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
-index b7cd765c..38497765 100755
+index b7cd765..5dbf3fb 100755
 --- a/policycoreutils/scripts/fixfiles
 +++ b/policycoreutils/scripts/fixfiles
 @@ -1,4 +1,4 @@
@@ -44,8 +47,8 @@ index b7cd765c..38497765 100755
 -	  [[ "${i}" =~ ^[[:blank:]]*# ]] && continue
 -	  [[ ! "${i}" =~ ^/.* ]] && continue
 -	  [[ ! -d "${i}" ]] && continue
-+	  echo "${i}" | egrep -q '^[[:space:]]*#' && continue
-+	  echo "${i}" | egrep -v '^/.*' && continue
++	  echo "${i}" | grep -E -q '^[[:space:]]*#' && continue
++	  echo "${i}" | grep -E -v '^/.*' && continue
 +	  [ ! -d "${i}" ] && continue
 +
  	  exclude_from_relabelling="$exclude_from_relabelling -e $i"
@@ -84,6 +87,3 @@ index b7cd765c..38497765 100755
  	fullrelabel
  	return
      fi
--- 
-2.34.1
-
-- 
2.43.0


