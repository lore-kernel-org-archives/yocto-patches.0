Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EACFE9A047
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 14:08:32 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12621.1771423704677992478
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Feb 2026 06:08:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=kg6lSSqP;
 spf=pass (domain: smile.fr, ip: 209.85.221.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4376de3f128so3678748f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Feb 2026 06:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1771423703; x=1772028503; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNitFw5yPGf8A180BnqdAbwy+9fptCF2ngPiAiGi+XM=;
        b=kg6lSSqP/K1+yp/GhORFgo+fLVrYKchOPMcWw0uhsMxxfvdfkuGX6gmB2bHTc7KV00
         CvHaTce+7siBbUNF2HJWiC57IvIUiiH8KUoVJ97504uUNTRoPeZ4ixcVO+hbnv66ssl+
         16J9yp/5z/Uo6xF0DS/dTrVzofqZRXThEqOBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423703; x=1772028503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNitFw5yPGf8A180BnqdAbwy+9fptCF2ngPiAiGi+XM=;
        b=WMkeoOd9NmB8CsVkNyBnLvGB781gyaFMOElq2bEMfdK0n1nBIjAC0NfdEszMjNO5sY
         w+O9S1eUpHtJA0/EiHdgNGwewGAIh8y16axqkskVMiB1L/UGPZU5FTE9B6zMfoFtC+aa
         mRF2varI5s/kYAwxptT3qkErlPP4/dOJdHpXUfFbwj0YKNbIb3ESveSWTIq3ZT9aQnAm
         wjLA7Cq4zZSm+TN52ZDrax2TG9zU96Z8rE2hxFuEUQ5YuX/dGRQsdWxYyiDiIM0imRLI
         CQuJHkDS6BUdekcz0kQbJ5FcJoJBmxN9B2tobBbu2scPliFJjRvfZMzpPxPcYvE5eXCz
         VOHQ==
X-Gm-Message-State: AOJu0YzLbGeTgVZOyr4gghCmpkYthuP5BRgOeX88SdQZpiJVJqdmdarl
	LV0HUw+oKgj60U+pgf3/yIX9GXrQV6ouRDnhT7Sr9ZxKNHAM14YaFBVA3hcuSnX1tQBJDOf28a1
	X9VD7
X-Gm-Gg: AZuq6aJn8nMqYsGk8nqTb2CPdvd9WVucUFWIloVoVLASJY6RvQEvgwuvwf1vbAyLds+
	whRyonotH6wMYu0sg/y+DreaaSOWN/VSjyZAQTP6JdXcnOwbJc88z2+XX8kGGyPcqYbu8NhI04U
	nZgKbGym93IbaseickX2sXBEEytCnTruw8te5/5Egj3hOKILxrRaOy4UIv6lmX70fiTaZZus3Qo
	hdbgSNR79D8mc9ay6xHfvJLp1yJaDje21/SFWNEPB+sjfpts7xetm3WylZV5tDz/oVcTH0VRqmf
	viB6qZmpZpY4qkdOkXJCdjCECEbbOXR+JtubQIGVCeOZLa0oYJSULmZKQMQLh8mtsZZxf9s01Kt
	mLUDQlc34txjwJh5beHfVa9ww8P42I9mTuEtqp0DidfjAHExXd/kMDyVmKnIYPuxfskpF5PZ3KT
	zsy9DTJ9WAmEHMWm4nqg31/WGva5EnvYuMORoot/8VraYyUEntCDgZU6IBLlMzgXY7Zmtt41e5C
	cDKM63ue/hoRESdU8YdDNXjwhjBgWgvuw==
X-Received: by 2002:a05:600c:3e0d:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-48379be7576mr248280695e9.31.1771423702657;
        Wed, 18 Feb 2026 06:08:22 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dfb4bd4sm536278225e9.7.2026.02.18.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 06:08:22 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH v2 2/2] config: Add supported workers (as per doc) for kirkstone
Date: Wed, 18 Feb 2026 15:07:30 +0100
Message-ID: <20260218140729.541081-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218140729.541081-2-yoann.congal@smile.fr>
References: <20260218140729.541081-2-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Feb 2026 14:08:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3256

From: Yoann Congal <yoann.congal@smile.fr>

Debian 12, Fedora 41, Rocky Linux 8 and Rocky Linux 9 are claimed to be
supported in the doc[0]. Enable testing on those.

[0]: https://docs.yoctoproject.org/4.0.32/ref-manual/system-requirements.html#supported-linux-distributions

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 07dce84..43aebe3 100644
--- a/config.py
+++ b/config.py
@@ -195,7 +195,7 @@ workers_prev_releases = {
     "nanbield" : ("alma8", "alma9", "debian11", "debian12", "fedora37", "fedora38", "opensuse153", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "perf-"),
     "mickledore" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
     "langdale" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
-    "kirkstone" : ("alma8", "alma9", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "fedora39", "fedora40", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "ubuntu2404", "perf-"),
+    "kirkstone" : ("alma8", "alma9", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "debian12", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "fedora39", "fedora40", "fedora41", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "rocky8", "rocky9", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "ubuntu2404", "perf-"),
     "honister" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "perf-"),
     "hardknott" : ("centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora31", "fedora32", "fedora33", "fedora34", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu2004", "perf-"),
     "gatesgarth" : ("centos7", "centos8", "debian8", "debian9", "debian10", "fedora30", "fedora31", "fedora32", "opensuse150", "opensuse151", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "perf-"),

