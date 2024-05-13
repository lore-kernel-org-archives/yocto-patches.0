Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B2C41513
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:30 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.62814.1715612366502971693
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=UAc/9htd;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.41, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59b178b75bso872843366b.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612365; x=1716217165; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H8CltSC/cr/a7ObUq5M0lQof9mL6KkkNnQ2EODRqSZg=;
        b=UAc/9htdqBKhUjIo4O/uWoF/7un2aQ+lsEgh56Q2zstZT9+xMHWr+lp3jWfdSLL5l4
         eX5CQlDVu/JKbTBk1m2qTBpTZYnkOQjbGBetY9QI+262i40SOJWNE+OpvnsOnttHMuwh
         oKGYR6KSUU7X/wUOuHNddPWCukPQeOH5j5t9IHzDbErxEHVcd/VUy2Wp5y/VS3+R0BGO
         qNfVcKmwiZ1sc1LRmkhxsEhMEZX9hrE/hug092BzTN1S4/VX9EvicdtKGRVAsBaZ2i+4
         WQ/6fFfmGqegQqP0lu/O8kKs5ArdFp3drrJ4aKU52WhxWY+D9Cb2rHJUWnj8Kfw2y1Uv
         EQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612365; x=1716217165;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8CltSC/cr/a7ObUq5M0lQof9mL6KkkNnQ2EODRqSZg=;
        b=bJve3n92cIX/a9CUIPOltBTikVWJvw2+iC7Og3E+Blmc78sn3kM+vCq7KIp4wIqIlT
         va7BOoCptsO3lQ4wU4ew9TndMkjW4jlI9SDWH3hyl9gU3t2/pH13TPid130y45vJHzfo
         PhDj8GznOX/pi8Lak2sZfce9yjhdWycNEU4OdUnESzT1zGq6SgUwNjeJLM3SFzlmJ/6n
         dM71SrnFUzZwj7qxekLcRUYl6FWayhkAad4IW6h/7cWkg6/faYOKByN2Jv/VakCcSof4
         QavJAZKTkji09oGVJEmwWhfVVYl/+34WA2bZWUhiP/NlHS8nRUoaTPj/fwHw0Duiu9if
         zbgA==
X-Gm-Message-State: AOJu0YxVYjx2kyBtl9RgRtXDvWP/qcGymtft09uSr0h5k9o6RQPdJ23K
	2xLnRnnHsdebQVAswT0pkpgGu2sWLPSdI446ZbQwf6PKxTwzOLqDqKpG2ERFX/EqPDGnZD0iFdw
	g
X-Google-Smtp-Source: AGHT+IGsUmYX5Tz/qVAg0JbOEH5Sv1oBT572ZbJM+TQa279CxVTQ3khoVzWBMJuU5RSiV1i4L4f+CA==
X-Received: by 2002:a17:906:7215:b0:a59:9b64:216e with SMTP id a640c23a62f3a-a5a2d5f1a0cmr787023066b.46.1715612365097;
        Mon, 13 May 2024 07:59:25 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:24 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 01/12] patch-status: add .gitignore file
Date: Mon, 13 May 2024 16:58:50 +0200
Message-ID: <20240513145905.4167-2-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240513145905.4167-1-ninette@thehoodiefirm.com>
References: <20240513145905.4167-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 14:59:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/121

From: Alex Feyerke <hello@alexfeyerke.com>

Don't commit generated files used for local development.

Signed-off-by: Ninette Adhikari <ninette@thehoodiefirm.com>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 00000000..314548a8
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,4 @@
+# ignore generated data files
+patch-status/cve-count-byday.json
+patch-status/cve-status-*.txt
+patch-status/patch-status-*.json
\ No newline at end of file
-- 
2.44.0


