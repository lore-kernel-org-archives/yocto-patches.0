Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1E6CCD180
	for <webhook@archiver.kernel.org>; Wed,  1 Oct 2025 12:00:02 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.15491.1759319997248300385
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Oct 2025 04:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cCK+KvTT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e2e363118so68351325e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Oct 2025 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759319995; x=1759924795; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGcwjG5npK0cNA9Xn/LeHu9CYTzexag+Y9MC/wR6ikk=;
        b=cCK+KvTT0Zx4Na42iYtuAUrZiJZKhlGtij8nwwRPcXlgpkfCtysOdhsxSu6gu5pbN7
         i1YXJihhNQ6jBIqlIkKyUbnRhb7KF5aX1Gfb69J3NLyV7b5lwU7HFh5DPltgljxr623S
         30XL050+K0eDFnpdZDHwgDCNSRGFiDO7B9GYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759319995; x=1759924795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGcwjG5npK0cNA9Xn/LeHu9CYTzexag+Y9MC/wR6ikk=;
        b=bwF+YfKdQg50TAbWLwXAGYBlGUt5ywQ6dLbAHVWk6grfslOEtkzvxpyCK333jbyTMh
         2pNfMZE/isoiU/okjXccB+0CD7c72iPNwZlUw5r/EVT46wYthwjlKgal9GeJhC1DDUa3
         zG25ozqtg2AIc/YVvjW/v5VBG3tr4EDYaewDrjA2XLWLSF2cyIERtrqhZQhwREmcGhRO
         wBkGMxn4rEWn+IMmONybMtpvGU2DwY0tycdZriYCrOfGKd8WMKlWpX9rMHsfZtRmFn13
         OR8iA4+lXWJ0tXI/kek5/0P1SxrNNA2WbqQDuQKMZYCph9g7D34cB7O9tlXX1P8fosCI
         uPrQ==
X-Gm-Message-State: AOJu0YzMHOFEJRFvUjoV+8xoPbAcIlYZ+113+hE2+8gEAu8HIRihQe5l
	xgJywPc4hcRrDRnWTnI4knNudyv9IbadbbPSCiuZ7c9CQMH92XoHJUHruMqqKCJsvQDCjGXwXjU
	vLmMt
X-Gm-Gg: ASbGnctVMAAxnLObAyF46mpDxHaouE8APTqprBvOJXLbbNXU+8LjKEjsaIRZt8GiX4N
	A3JdWkbzCRHZdVpabH8KsFssOfAXRtEpw0Pjm2DfjTYQphTWSeVasnSjM18/s7R06xkFspjY6x9
	/tI1ofpYKFsBpbUEAtx9RLx/SxVrsOOOWSpMY2oGNnHz3WNUFbG2v59pZecwgVwJgMNVpHyHfTv
	KmfzA+tFkthzLDE/ZWCenWoLXdoqUbFsi4NCCOP3eKqbxF6B2qSwe5FCnDz6XfSHy2dIy1gtDY5
	vEjyiWHkVtNzP6Z8OLMKf2KmaYnD/zHTfggiTY1BGs61s3KRes0hNjUK5muEejl6ISzxFEEFjw+
	A2f8YiV0Iv6ocdsMgYxqwt+wN1q5uc+IaUQTrIH/gFnQXnXHe2A3bc28V+6Mg0gJjUkXbfavb6t
	0=
X-Google-Smtp-Source: AGHT+IFTZwyK/rlKEHCeJvGm+/ASTPn+x3wAe/socZBH7F6doaAbuRyjeXH0DjdflSnwTVe/34SiMw==
X-Received: by 2002:a05:600c:8887:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-46e613dd418mr19199335e9.34.1759319994955;
        Wed, 01 Oct 2025 04:59:54 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d53b:59af:db6b:d4f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a16e13sm37505535e9.15.2025.10.01.04.59.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:59:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 3/3] config.py: Drop ubuntu2004 workers
Date: Wed,  1 Oct 2025 12:59:51 +0100
Message-ID: <20251001115951.253600-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251001115951.253600-1-richard.purdie@linuxfoundation.org>
References: <20251001115951.253600-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Oct 2025 12:00:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2266

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.py b/config.py
index 8c128ea3..991ac6ce 100644
--- a/config.py
+++ b/config.py
@@ -162,7 +162,7 @@ publish_dest = "/srv/autobuilder/autobuilder.yocto.io/pub"
 web_port = 8010
 
 # List of workers in the cluster
-workers_ubuntu = ["ubuntu2004-vk-1", "ubuntu2004-vk-2", "ubuntu2004-vk-3", "ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
+workers_ubuntu = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
 workers_centos = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1", "alma9-vk-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1", "rocky9-vk-2", "rocky9-vk-3"]
 workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1", "fedora42-vk-1"]
 workers_debian = ["debian11-vk-1", "debian11-vk-2", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1"]
@@ -172,8 +172,8 @@ workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + wo
 
 workers_bringup = []
 # workers with wine on them for meta-mingw
-workers_wine = ["ubuntu2004-vk-1", "ubuntu2004-vk-2", "ubuntu2004-vk-3", "ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
-workers_arm = ["ubuntu2004-vk-arm1", "ubuntu2004-vk-arm2", "ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
+workers_wine = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
+workers_arm = ["ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
 workers_buildperf = ["perf-debian12-vk", "perf-alma8-vk"]
 # workers which don't need buildtools for AUH and are able to send email to mailing lists
 workers_auh = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1"]

