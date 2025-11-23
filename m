Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CB5CFD31E
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:53 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4871.1763941548264716718
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=OrzHewmq;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b29ff9d18cso370993785a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941547; x=1764546347; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBC/XrRDvE0M8TreB4urm2ooDaHGxqvxsCfku8Sqw5M=;
        b=OrzHewmq0GYLimhDtlFk/e/LpoV5BQcBd7iyTVg7LM1k5b75s8xR/Xa6DDx0G1/0rZ
         xAZUPv7iLJlvJ+eEqQ9zb0ssjSQK5KKWMzFqSkjcIIEO5ebwBxO0W8id7chD+iH3kfAq
         O3/xMvNWNLZMR+Z0kJzSv223CHu0vtx8Swyyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941547; x=1764546347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zBC/XrRDvE0M8TreB4urm2ooDaHGxqvxsCfku8Sqw5M=;
        b=h4f9fV3PUqT2INO58+WmMVCDnfHbL2E3u+bkI/p2GfEH71Zrnq6B3jpx8uWpZvv4KS
         VVr7jBraF6zhLzFU9ZJzZe+Q2S9zfKASwm0D4y1H5eTGLDTRj0oymb7f89Qu5OvrJMmI
         o6x9s96FyLJX/zIN4NV/KY8mWhahllP1+sCL/rFMejzDPIavUNPHp+MT4SYJjm5Y+g4a
         jsloSrlQRIWMutfMB9C2Bca/wqz7rIbthgWSwcrOCFWTSbcMyJDk9/16EXleWnC6Tp2m
         ULH+D+c6ynF5nbpgxxWDCTN/Pb3TAKz3sKVowA1LpHyysQVjIjnMurjw15sl6OR/0Nfc
         04kg==
X-Gm-Message-State: AOJu0YxJvFpce22foSncX2kYZOGAx3OeU9nbBuodrswzZRtJjAdeIGXV
	H01y7aNHU3EgtAnV3nwaJlE6YWZZcP24K8vAIn68zBsisSq78x6l+mhvN9hGhKSJa2MiVvpCYGZ
	I9m8q
X-Gm-Gg: ASbGncuUmZ86zoW0y1wSXIKBs7VlQax5L3ExAoQPy5sWBeup9R5VqxYdvfIDFXklu+X
	hl6eeGOYR+vN5FFIPOQZ79VoBi5C+l0Bv4Xzh5DhtbPW+1nCSV4o7MSHDWBHrP4nZv01g0QQliP
	fqG3oINVfi310ygya/Z2L2FGc3kGRRF1FiI1y51VWWh/P7PcJJsgjjuOljzeHAmPR4ROlGVVD1l
	FWVSdO1Ez4ea100p8kcPIr1EszqKN4gHvRp0bJ4nZMAEo5nAUb3ImpmF3GzkXc/fDtsdrfY7VXT
	jZU2MlVRejFUQSt4X0N3ZEYxjT7gR/ios33n/93GOzmvhZlDSf3+58MqIQkQEWHXZ6zyx0U7sO5
	z2PmV+YrWt4nHK7OfeUFozcalU4n8iBnoGBZdUZeEAhTLbIjq3+8eCRSUo1AAe6QdL36TjjaV0s
	pWM+6dZm6FY5ooa23lv8SnPf/DZEp+nEFCKAvYdJybJN7MLEGvjPUU6L2bDMGriSE=
X-Google-Smtp-Source: AGHT+IFKw4+g9ZjcATBPAHav+goc6NmC43j5XnqB8YebbftVwiVmC6OPnoCXHRTuN4zNn25Bw3+XtQ==
X-Received: by 2002:a05:620a:172b:b0:88f:4264:ea78 with SMTP id af79cd13be357-8b33d1b2482mr1300752285a.15.1763941546687;
        Sun, 23 Nov 2025 15:45:46 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:46 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 28/32] suricata: drop pkg_postinst_ontarget systemd init
Date: Sun, 23 Nov 2025 18:45:08 -0500
Message-ID: <ea3ab291df9f2c045c8796fc02b97b09cb020cba.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2686

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

/var/log/suricata initialization is handled by
systemd-tmpfiles-setup.service, which occurs before services like
suricata

Work towards resolving:
ERROR: [...] do_rootfs: The following packages could not be configured
offline and rootfs is read-only: ['100-suricata']

Added in commit 36d656fe7244 ("suricata: add tmpfiles.d config")

systemd testing:

root@beaglebone-yocto:~# ls -d /var/log/suricata
/var/log/suricata

root@beaglebone-yocto:~# systemctl enable suricata
Created symlink '/etc/systemd/system/multi-user.target.wants/suricata.service' -> '/usr/lib/systemd/system/suricata.service'.

root@beaglebone-yocto:~# rmdir /var/log/suricata

root@beaglebone-yocto:~# reboot now

root@beaglebone-yocto:~# ls -d /var/log/suricata
/var/log/suricata

root@beaglebone-yocto:~# journalctl -o short-iso-precise -u systemd-tmpfiles-setup -u suricata
2025-05-20T00:45:46.450027+00:00 beaglebone-yocto systemd[1]: Starting Create System Files and Directories...
[...]
2025-05-20T00:45:47.041049+00:00 beaglebone-yocto systemd[1]: Finished Create System Files and Directories.
2025-05-20T00:45:47.542976+00:00 beaglebone-yocto systemd[1]: Started Suricata IDS/IDP daemon.
[...]

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
(cherry picked from commit 9109f7258dc60c88985869ceff5ca3523cd01400)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata_7.0.0.bb | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index e2e94e2..7a6b930 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -148,9 +148,7 @@ do_install () {
 }
 
 pkg_postinst_ontarget:${PN} () {
-if command -v systemd-tmpfiles >/dev/null; then
-    systemd-tmpfiles --create ${sysconfdir}/tmpfiles.d/suricata.conf
-elif [ -e ${sysconfdir}/init.d/populate-volatile.sh ]; then
+if [ -e ${sysconfdir}/init.d/populate-volatile.sh ]; then
     ${sysconfdir}/init.d/populate-volatile.sh update
 fi
 }
-- 
2.47.3


