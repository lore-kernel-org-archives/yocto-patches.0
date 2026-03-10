Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68941EB1048
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 10:28:01 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36822.1773138473311518173
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 03:27:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I5bWi8Pq;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so32192495e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 03:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773138472; x=1773743272; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS8QEH/zkNSVuxw28nuqF4tSy3jyUXDAvKPsy5W8dG8=;
        b=I5bWi8Pqqi3W7h4AMVkjyq9FMOESljD1hW1+RwiBzQKIG41JoGPqV9irR30DNi67Lr
         0eeSoC1DqJkoQTu2GsA3dzV4HudE/holh+9CrUe5F8Uem3Q/QErxBw6mZJ6oCoM3O2d3
         QcU1LdRChBG4//8PQaQzkkSd/a8XOfJ12JPFjPmHVtyGgbjh8ItqYPs5aVCDyPfCHDiX
         uwggK2D3IQCyYAk1IM7UkO1JnQYnrKwmjferxFGlb8NR/IlQB5b5SEPi+mpnyQyNaJE1
         NTZ9C4W21YUWaN3W56jiPfFK9m5KFg6HLhGNxy3eA3KbUBxYYcUwyZ80w+vKdEqoegSE
         bIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138472; x=1773743272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zS8QEH/zkNSVuxw28nuqF4tSy3jyUXDAvKPsy5W8dG8=;
        b=cgTVcQ3Q+iKNN9Vupb5quMhLrFRVTY1xIe7tT6n85pH31zv6S6eT4UZ1jnF1paW2/e
         GLv2eiAPg5tihsjMwdr5pi00gZdRfeIs6n1QJn2yoachxdY2yVoGmhHFo/HLzCh/Lqz8
         tETM4fhGrTOGm4PiSbRyJO5dt3BCTLxDAncqtVJhGZ2qlKVrvxl/sq9cJtlWZEVQJums
         YBriClLVDdD7jaVMTQlbI6Y0eS/D7hHXVrsd/9kl2oqMtpycUXz11p0p+1J+cU6OrBO3
         Qr339ClpNgUO3bgFlPg8WOGcUGkeC4vbup6i4+1u044yjK8rehLpzG5P/3qYI2XVE6Ez
         rIIA==
X-Gm-Message-State: AOJu0YxLVIgysEQxzchymxE7aq/49oELMeIu+k/KtsOdHAAinVYbEuUx
	lbbwQZP8vCVenfK53VPyD1POJyCIqZkFrDaVLXpJASkDniLje3QQyUsvSrEgIVdZ
X-Gm-Gg: ATEYQzzZRu5BeMQKLoEEO9UYlKOAbHhiYYFDFLpCFFw9rHCj6jJ4lS2UOX7aoD4pjWG
	+Wf9nU3bZxJvC7ryt9Y+Iwh02hOZTvtjYdxoZp0sLV1DCKHrfIqTXrAVYRD5KWOkuoz5Cx3Pd+n
	V9f3tFNFottIpKm3yiHv+kuqPo6LgpupEnVLFGZGyBHIlfngHnnb/W7RgfF5DhcKuHGO9T4mnuo
	QI07yhXlhqyO2TIP7hueYypNO6dSMvLT89vmJxDVE9Sm1L992aIZKX26DPdmCSuoiUBsnCAjuuI
	8u2U8Tv/Qbl+4c/KB7bec+FdTINlAD4/HeWyixlk3L6OYdINScO6BNa4r6mUBQj6fEMXg3SuoPL
	EUxN1Cvff7zVTMPNLEQ4grvJK/ORoFaLZfToh4sNe84bJdP9XLsvOiMz4O4EelpVVccNhf2eEOx
	YclWBde6aEcKyhjCzc0xfQrpao/Q==
X-Received: by 2002:a05:600c:8b26:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-4852697a5c1mr235018205e9.27.1773138471334;
        Tue, 10 Mar 2026 03:27:51 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6b7sm86785555e9.9.2026.03.10.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:27:50 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Armin Kuster <akuster808@gmail.com>
Subject: [meta-security][kirkstone][PATCH 4/4] packagegroup-core-security: add dynamic python pkgs
Date: Tue, 10 Mar 2026 11:27:39 +0100
Message-ID: <20260310102739.2743995-4-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310102739.2743995-1-martin.jansa@gmail.com>
References: <20260310102739.2743995-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 10:28:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3394

From: Armin Kuster <akuster808@gmail.com>

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../packagegroup/packagegroup-core-security.bbappend   | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 dynamic-layers/meta-python/recipes-core/packagegroup/packagegroup-core-security.bbappend

diff --git a/dynamic-layers/meta-python/recipes-core/packagegroup/packagegroup-core-security.bbappend b/dynamic-layers/meta-python/recipes-core/packagegroup/packagegroup-core-security.bbappend
new file mode 100644
index 0000000..828931d
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-core/packagegroup/packagegroup-core-security.bbappend
@@ -0,0 +1,10 @@
+
+
+RDEPENDS:packagegroup-security-utils += "\
+    python3-privacyidea \
+    python3-fail2ban \
+    "
+
+RDEPENDS:packagegroup-meta-security-ptest-packages += "\
+    python3-fail2ban-ptest \
+    "

