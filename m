Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204E0D59D85
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 18:24:33 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.173.1765563871888843318
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 10:24:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XxLJ5aHy;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b21fc25ae1so144421785a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765563870; x=1766168670; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDgnLNLqWZ6+O4D2mYOnJ0EDDUTta8btgkz1wrxJOYg=;
        b=XxLJ5aHyPLURWIJq3RbpgZRYxQ3Pw1ugErChpGZkdpSPatHKQvexpCLEmeI40BW61o
         OP8q11JbF6NbcCou8R3EOuv3cZKi+nlahGjAAE9mndAuN8qrjHBrtbLFdnPeoJbndFf3
         CAkjxJoDZAnlklY2QNEyiRkLbR0UPyRvRjnY4HpO+DEoyyCmdhxJmdQdul2mNGibByLg
         f1oq+WUEhexlRkMRroMc+NMu+EISUwmJ2oNdbj4wayLT0L9b8xZTIRkTNCq29vEJWuDv
         zxYezsxVgFbs8uMhpIXFJMs4KnrrnY4nZDEqDk9Pbi3soaABrsYZp63B2WO0rbu3zTFx
         D1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765563870; x=1766168670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uDgnLNLqWZ6+O4D2mYOnJ0EDDUTta8btgkz1wrxJOYg=;
        b=pN0aSgaaOEvTK1RhF58nAmHna+otbdaNhn3fuS8ZqWadjFWdbBvXhlFvn1lGRN1Fko
         9AQWR3KD7C7d6EuRpWLf47lYQfZY1Cpz/ZwI//3q2u4krdk1oznkbT/BP3WJJUeCtix/
         f9jBzTz7c4ffNug/weYi1FsQdwnhhDKozWdczxyOzmxQNHIPieCIU//TBY7LBvNhP62B
         2CYRPLuoqHLPFroMLOGX8/sIbHq79V/GMtNapkMriFP8YOyaETMzvtt4RMS5pEWEzquV
         X/78+xmRNUput0Kv4nLQ4U6RcDggf5/rphgv0hidum4ei/uFy1x8jasNd7vZqiKN9gzI
         Kr2g==
X-Gm-Message-State: AOJu0YzdWvQCHzOLBqVrBu79HDbcl1ZWZv86b6TRguWqUDbfqGU3hgfO
	uHhZbEX0OrjP7718BBZDtmZPTjU84R0LBLpFEUnLEjj7/SWIfkIVYHA0dGSZkA==
X-Gm-Gg: AY/fxX7X9hOmBX2TwzmBxLLZz0w55/isUX3j33RPEd6Dr4a6xCuOE85yUv4Vqowq8nr
	xXNhxMmpL1LqPhfRsX4/kWXsgkVmBFGYuTWYdb9Vx333ilnY+64afjtmaC1chD4jH7tKUC2hk+f
	0ZuOVZcbpUkKkk96/ue+vVqW6bSh69GTw0uf4QWI7ZkJZKgh2B/KLEN8lTjV94OzuhV7iOcPFBO
	k4SUklSUthORX+cngx7cd879YHf0bAsMw7aqAwZHFum+4D9wJOcu/U6CSIqJZqih1RFh1pEkLMw
	RGXrBNrKk/4fSfameXdnC2PCBrq43g0+vpnHNqkuuA0kncjEISp3ikfurqSJKtwUo2ovr3Itm/s
	dKA+nZNyHaXjXpuYWbyEcnNti/Zlkfef6KloAsptO/WSPSNCxjDcJGBUXvRwBm+LFOgYwVunGeY
	cFkJU86Go5q0uYwn7GAx4/rAy9msq9HchIN9Pa3A==
X-Google-Smtp-Source: AGHT+IFyigtS9RtTzKqH3dqFDIGnVz3ZMUTG58+fru68KzmULzrt8hYqjLXAOs9xGBOWa8unFsRLDw==
X-Received: by 2002:a05:620a:4116:b0:8b1:5f62:a5d5 with SMTP id af79cd13be357-8bb3a3894e8mr408825585a.62.1765563870377;
        Fri, 12 Dec 2025 10:24:30 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3bd62sm537745985a.35.2025.12.12.10.24.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 10:24:29 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 2/2] abd-partition: place unit file in system location
Date: Fri, 12 Dec 2025 13:24:20 -0500
Message-ID: <20251212182420.24920-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251212182420.24920-1-twoerner@gmail.com>
References: <20251212182420.24920-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 18:24:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2776

The system location for systemd unit files is in /usr/lib/systemd and
local or admin-created unit files, that are meant to take precedence
over the units in the system location, are to be placed in /etc/systemd.
Move these unit files to the system location instead of putting them in
the override location.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes since v1:
- added
---
 .../rk-rauc-demo/recipes-core/systemd/abd-partition.bb        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
index d5cb42738e72..65a52395dfff 100644
--- a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
@@ -21,8 +21,8 @@ do_install() {
 	install -m 0644 ${UNPACKDIR}/35-rootfsB.conf ${D}${sysconfdir}/repart.d/
 	install -m 0644 ${UNPACKDIR}/45-data.conf ${D}${sysconfdir}/repart.d/
 
-	install -d ${D}${sysconfdir}/systemd/system
-	install -m 0644 ${UNPACKDIR}/data.mount ${D}${sysconfdir}/systemd/system/
+	install -d ${D}${systemd_system_unitdir}
+	install -m 0644 ${UNPACKDIR}/data.mount ${D}${systemd_system_unitdir}
 }
 
 RDEPENDS:${PN} += "e2fsprogs-mke2fs"
-- 
2.51.0.193.g4975ec3473b4


