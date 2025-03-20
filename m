Return-Path: <jarsoper@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1676CC28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 11:08:18 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.4800.1742468896432413823
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Mar 2025 04:08:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZLdOLYOH;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: jarsoper@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so4801175e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 04:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742468895; x=1743073695; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lt2ygMVohj1rPrGgVgAxn1hHC++opBDdajMDQTipV8U=;
        b=ZLdOLYOHJDLMIY9seLTOg/Y0cF18SZoYIBQ48qiTKOZxiqDZX3+iOaS8I71jSqzzD9
         QmeBPFA2ZChimF1jnY4B8cYHmfwysczbzsk0Mi9YhC+vhTMCx/tqD0SqoXrbQwGMBULX
         ZISidyCLkeXs4YC8mYH369sfISVlGyzNkEHFfINdElGP0YqgcfKtC3U/jNOPT4l3xe4b
         u6G3baQKeBiZsATYVZtaiiK7JmtDddRqPDER56vHTrXH9S/yFq4SOJUDHfbcsb1cjK0u
         lH6uzi1E7NGmJ02Oe3gk2PKisMgXkja57D+Se/WROoBZfy2mrLm/nwUwz5QG+UaMdO4b
         JgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742468895; x=1743073695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lt2ygMVohj1rPrGgVgAxn1hHC++opBDdajMDQTipV8U=;
        b=NQZymD0QJKFHm/9dczwMKLx1GzPq/NBPYWpQ3KaQcUY8e8KYfiGP9BFDchoEYXm6C+
         gVH+j671V+qg+XAkIk4/CBytaqTsdZ6cIGqNZTPcoZvSi4S8KP2Tw+tRuu5FCiczir59
         Z8yE6ggUN8dSYgyoYhqnNCwDY2cmR1qljrFVMmI27M/L9R72/yf1A+gs70OuMltHVG+d
         hkNMUYvxWdVWOImFYUY89WVMb6RfTzNHAMQDyk6zCa9FMrtlr11+R1krhk/E8k6R2fgO
         IeE55MURtsN6esOthjnLTfvJ013DU8E8MVkqWE3YxxxANHzINTnKLgw1t+Jzjtojj2NV
         NVWg==
X-Gm-Message-State: AOJu0Yz8w5icAHNv7rn1pfDPPUtlh9e7Jlydme9lQw99kabUKAOJDEC4
	+igw5opnIlXf+OWVA6Y/VNG5rIrArxQ3nu5Psiog6TbUTVLwLXkUel/G7bb2
X-Gm-Gg: ASbGnct0pM/uYFg2Ny25OywAUs/udeC2HxrdqlRB0PuH3qSNk6lemYNUj7j1k0E/4ez
	jPVmgPzzBCxa/DzXDZAlgyNiJzKGVueoRbX7AcStNWksxDqvs2DMuSJA9l0PAxnQT24c5szSfP5
	G5q/BxHb6/p3tjq2s5pqeTsQZtXDMoUf/vq4RS55vWyjbp1WvPy8TqxubpdsD+93m9zUwF2lIBb
	m5UOuyDvwe0my5702+RMFQwW8MjVq7NK6dkQGa25YIeU4uFK9/Q4dmhAZ9cUWSeK18s5KuCdaD6
	bE96g2S+1fywEvRNLj5KK+21rgZDKcq4F54o0l43iU4Eyop0I5gr1vMWexG0mEJggB0B1ZbUXux
	Xf1TdNMvZjTAEUXO0NworOufN5TU=
X-Google-Smtp-Source: AGHT+IEdk1+wHM9TZ61CHv+dKso0F/tQbjFET4EhNLQemiGwwf9Esc3jxYu09ba5BldLMOWhO5CH1g==
X-Received: by 2002:a05:600c:4e47:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-43d4384226dmr58403995e9.23.1742468894324;
        Thu, 20 Mar 2025 04:08:14 -0700 (PDT)
Received: from fedora.. (2a02-8428-db71-3701-4910-aa42-71a4-9a4f.rev.sfr.net. [2a02:8428:db71:3701:4910:aa42:71a4:9a4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebbb7sm24088402f8f.92.2025.03.20.04.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:08:13 -0700 (PDT)
From: jarsoper@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Jean-Pierre Geslin <jarsoper@gmail.com>
Subject: [layerindex-web][PATCH] layerindex: exclude vardeps from PACKAGECONFIG parsing
Date: Thu, 20 Mar 2025 12:08:11 +0100
Message-ID: <20250320110811.229287-1-jarsoper@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 11:08:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1230

From: Jean-Pierre Geslin <jarsoper@gmail.com>

When the PACKAGECONFIG variable is defined with an anonymous Python function,
it is mandatory to also set the `vardeps` flag to ensure that bitbake follows it correctly.
This fix prevents the presence of `vardeps` in the PACKAGECONFIG web interface section.

Signed-off-by: Jean-Pierre Geslin <jarsoper@gmail.com>
---
 layerindex/recipeparse.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/layerindex/recipeparse.py b/layerindex/recipeparse.py
index 9be6c10..d593def 100644
--- a/layerindex/recipeparse.py
+++ b/layerindex/recipeparse.py
@@ -184,7 +184,7 @@ def handle_recipe_depends(recipe, depends, packageconfig_opts, logger):
     dynamicdeps = list(recipe.dynamicbuilddep_set.values_list('name', flat=True))
     PackageConfig.objects.filter(recipe=recipe).delete()
     for key, value in packageconfig_opts.items():
-        if key == "doc":
+        if key in ["doc", "vardeps"]:
             continue
         package_config = PackageConfig()
         package_config.feature = key

