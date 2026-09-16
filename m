Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648A8C982D5
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:53 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27092.1789597844278002388
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VcRtmyo3;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ca5aa8so14111485a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597843; x=1790202643; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/B0iyqx+N5P/VXltPELdkdgAOW5C911wOHHEcXmBo6Q=;
        b=VcRtmyo3RErvUv1JGgqHYJboiwo4D6hhb/pxs0VSHo9toWX8IGTI5JANTA3sVmXV6r
         eREcNEZhYO17TnlCEnWXoWzPIDFoBVonYu1bNHXrjnDEk3C3uiFV9tbKB8q7S7UPGI3G
         iB8zq8LL2LgR/3qMoWqXaakpAAl8ALjuAaqTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597843; x=1790202643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/B0iyqx+N5P/VXltPELdkdgAOW5C911wOHHEcXmBo6Q=;
        b=r/f/8l9OrFeNs/6Ia8REd/DAQVzrsDXIcPFkvbZ/8VZ9EyXIezRgqSle5SMYkuf2MI
         0YpiuKTdvpZkCibIbrGiHWaz2S88ua7ih3hcwEhHLB3CzCLuD9sVkwFMcyfjXwIr60dm
         icc6auajYwsb+rKLmmfL6CfKiH8B8sC9VEMNyuF5AHaDaIJV2ezGeMf3zlxvjKWqOj8v
         90klaNCrM4agP8S1d2Yug/tBtS4UQR00DfYRp0+OqIfk6RuNfUElevUqwDtPemRLHSpF
         mIG5Kk+D6PIIc/fTkWE0CCTwDYt6UzA9eYWHGKQpWgrH10QZL87W7P2D+GOH9/h8VIyr
         aDsA==
X-Gm-Message-State: AFuF++lmuZQxyj8WyqC5pWfMCGtqTfqJ9L39sS/RQ3noskWdfLgFSPwU
	bB4jw/1vi3g7QqdmSxYHeVJFwjLx7dJFzuidKmP9Lgiq58QRtAwQ1gk/bMBihr7YDgFLPV2F3FU
	IoVZc
X-Gm-Gg: AYBFou3a5U8D01r3IGutHaDQb5WkXIPjUnx/INKMLBneDmmxxEzFany52MpPScVMkc/
	Q00EqX/q+iXBVYeJtCpi2ixDdxgSQRJ0UGvg5OmuVak2bbPMHtGlIOaW/sEXAjl7pfRzTQxHdYK
	moD+5GCkFXUIdxsB3HiNUQOb8d6omk1ZBxUFpkm9qDOoejT5CWZyQGoMTfOJdXW/rQwrI90pWb/
	cM/FytPre1fEon4CIIAAFxOno8JmL4+JMrCQ3MD/FfGAISN6/j2Ry3T0xxlqigBj1K8AiZyRncd
	/aek6AfKRHyIkmds96BsXNSl6lch+z36iOtz+QdUv6RjMnHMW38fTtvrWacdR3FYiF3OKwcYfzX
	LjKnOuzJQwuWUvigzzVhhthtRGeJxgwGZ2YEOB1Gs1dD35CG3wc9tCj2qW2vPouBOxckl/OzvYK
	CpIUb136vLj1zH3USP0kjZeWe7Cz8ZjNLGDPPiEQrX1nrN+XrTnQBmh7bQ8qPONNvGIi9SaxtEL
	j6HW0UqpUUX7o23mp8qBVmrnq/6HSqSTgkZy9tLdkmlJk8IMJb/F3XxRPo0weRS/PGtmyvRlya4
	93pojJs3lmvS40vTKYraKRYYs6H78Gp+2pM=
X-Received: by 2002:a05:620a:700c:b0:939:2670:befd with SMTP id af79cd13be357-93bb787c9a3mr840686685a.26.1789597843099;
        Wed, 16 Sep 2026 15:30:43 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:42 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 13/24] scap-security-guide: upgrade 0.1.80 -> 0.1.81
Date: Wed, 16 Sep 2026 18:30:07 -0400
Message-ID: <f80269340cf19c13ca9e723bcfa85656caa5b4b8.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4889

Release notes:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.82

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...cap-security-guide_0.1.80.bb => scap-security-guide_0.1.81.bb} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.80.bb => scap-security-guide_0.1.81.bb} (100%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.81.bb
similarity index 100%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.81.bb
-- 
2.55.0


