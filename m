Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9674.1795884893195957301
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=MEhyB2sC;
 spf=pass (domain: konsulko.com, ip: 209.85.128.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so115433075e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884891; x=1796489691; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ts45SbjZoBdkVepcrsLKmyzK+KmuGZcGrA/nv1KzUO8=;
        b=MEhyB2sCmYi7UHqPFvx6x5MUsWCEatcqzvOCO5ZbbOBUqFrZuftl4g+7KokQrKsI+n
         rkVhsVLdJ8/Y7g9e5GhBPp1+OpTA5ifoc0i9il0dv92hHOLgRR9GBW8zUB2jaZIJ8q3i
         IwQTc/OZ3oaEGEm5aLP2nOO//rsKkjnJbBqIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884891; x=1796489691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ts45SbjZoBdkVepcrsLKmyzK+KmuGZcGrA/nv1KzUO8=;
        b=km8HcMd/jcISXCaO0ithQtvSBA3XC8bWsW7sxal8VDvm5nL5jejurl3tMHQdKcdZoa
         u5tqV5JDI5A1yuCSCAZdNz/mwQgFlQ9oFhCghB+9vF9MaqqILKbNRqairZChIgmI5fd+
         u/YAVEew4I0POUCtx711ebEcIfJxxxtxKSgjiILtD5lD2b8K3h8cZJ8nSpSuVHQvb27U
         MWK43ukknDzmDreft2xOBJ93cuZsSHpp4SbaF179yBnpIBzvq9rSwDbU/1hMOsVoktQ1
         HaNib1WfyRHr3AzWJlywSEAg/m/gFhaj6ustM5PvStP3O4F9GdUruTGZZrtGLOhnVmr6
         QPRg==
X-Gm-Message-State: APuU4Z9nSxYX04ENIM4ZqxaLLWwrJwIXHvly94+Bx0q1C6MvkC+pmXRO
	UjxC3TUsa6cvMDcEph6UdSN2jAOEglCreNuOfX4CThaU3AFTiZ6J41tvoeFgPleXKEMfbyYDCcL
	hlVMia04=
X-Gm-Gg: AZFdTZcJmWvDTGZDZIlwAJs5fKm+neifBxbxWY08d9Dc1rEG5cAiLojoyGWR3UwmVMU
	VPkW15DIMAt2BQajAIRfjEQl4bRD4jtzLbS159sPBGZQfAxn+kWeDMP0RxahoJiarSG+HBuvB8C
	lOzArhQEb/MiIxN6C2QaZG6jFkp/DFoRBg8DiaybgQczStNw8Xa+gSCGEYt0nSHeJn27+TQJ6Ur
	B56HdJx8xNES6xxSjH/QS/9adUXIKi2vm7EDvTl6HLohVMil5aBFnLQ/WTXJOv9GSlYQBRGzhio
	fHF4tl4pUYjGPZGq6bBbo3VZ0FrZMrxSXXRxGxbL1bnl1A6V6GOYFjPBWBQ5i9F7rENLy9qQzMn
	s4H05NcfyMWMCOpAGlteKYNhRKOWfP6PEkuOxnw1HCaK4flA2VbIPaDsXKlmfcB22XZWYwKA+gW
	wn4ZyItxiXiGCt2E34Mh+fTSbYfjxInWzWOEwtiVBT7MjFRD+bop8Zu6e72zlCapK+cxL5JaUkf
	8112+cNABvpAbTcR6S291Xz8NPsSlu/obt0kPvQVtAve4iDf4hpZNqFVPoruGi2iKj97czUOA3T
	aTGDxfTLj/P6SNpJUck22nTzJ0OB7httmF4q6uoSNQ6elJTuUDsVtpQexBLS98Ufg6xTMMWkfZ0
	JH9xWAkjj3I2xT7nA4aBq68BdPhFY/w==
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb887c3428mr562173115e9.1.1795884891265;
        Sat, 28 Nov 2026 08:54:51 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:50 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 05/14] swtpm: upgrade 0.10.0 -> 0.10.2
Date: Sat, 28 Nov 2026 18:54:23 +0200
Message-ID: <e6151a73296977e628b282480096d61f2865be76.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5575
Content-Type: text/plain; charset="utf-8"

From: Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>

Upgrade swtpm to the 0.10.2 release.

Release notes:
https://github.com/stefanberger/swtpm/releases/tag/v0.10.1
https://github.com/stefanberger/swtpm/releases/tag/v0.10.2

Signed-off-by: Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm/swtpm/{swtpm_0.10.0.bb => swtpm_0.10.2.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm/swtpm/{swtpm_0.10.0.bb => swtpm_0.10.2.bb} (97%)

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
similarity index 97%
rename from meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
rename to meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
index 8488d01..1e91a91 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
@@ -7,7 +7,7 @@ SECTION = "apps"
 # expect-native, socat-native, coreutils-native and net-tools-native are reportedly only required for the tests
 DEPENDS = "libtasn1 coreutils-native expect-native socat-native glib-2.0 net-tools-native libtpms json-glib"
 
-SRCREV = "54f4bb1e702a8b80d990ca00b6f72d5031dd131a"
+SRCREV = "32b5a0575991a73398de9749d63cafd847008af2"
 SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=https"
 PE = "2"
 
-- 
2.47.3

