Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9318.1795883248811046062
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:27:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Y5mBmyCf;
 spf=pass (domain: konsulko.com, ip: 209.85.128.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso111091705e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795883247; x=1796488047; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ts45SbjZoBdkVepcrsLKmyzK+KmuGZcGrA/nv1KzUO8=;
        b=Y5mBmyCf8AyTJKzxJriXDJF5SzMHFVO/K8E1+Q4J1ISMjBMN5yN0oQ+QgpP/EpmoAC
         oSrH2orNCCGwHQPBhSSqnWUO6fv5fZoap38qUUhOunU4KErtKGntLUqGwQ2nHl/LgJi3
         Ev0cj872MsTnilJJo7kX7h/TnJt+RFhi2hcUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795883247; x=1796488047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ts45SbjZoBdkVepcrsLKmyzK+KmuGZcGrA/nv1KzUO8=;
        b=cDhT1XvBOxz9NJuwAWOxbsugx+Ebp8n4oggLAY/CBQnXM6NkaenNgmHNsUVYg4DEn2
         qLZ0kUK+PYN26OguqxXr5QeUkZirBXXVHXdBP/NsOa4ZC6ZRvu4BpKNywXYMmoYDjwWX
         Fpo2a/YNR8si5jM4tJbqxP2SQMobnNsfuTawgAcwCy3615lRGW20QIBS+evv9BzRlHAW
         NUke48e/wj/v7/i8ks3AEnpAgr118vu9tiWi5imwt7agP8HgQq6exqA8YEY0F0NYgGxk
         iOsy4JyMhofOoOJ01wvA4hmzS6/lHGmacyezDceEIuBpRqrpDopX/4qt26e69KYUnyci
         eqAA==
X-Gm-Message-State: APuU4Z8+ZIDDJqY5mKLMiZsC/9pExvemDOl5/ur/JrF18Li4pvjFZJ+J
	z8Mv/KU8YuoKKwBBNoumfqrubTV+3mnLw/J+nHe++5bvUGGs2zOisvV3Vmb7W/Ni2tb4BS1TA5o
	UaJqn
X-Gm-Gg: AZFdTZd6u8kmPGfNy1Up8q/zpbQY6F4W9gqzNeF7yCYfnn6jm0q4vSUTiBS26QbDvsw
	Ly3pyYajN4+X8V4afSroI5AmCzvj8pw5iqCR/qFMwNZ0pEFjQsLIwU/ORJ2TVBqNCTpdNzci5Ol
	Xt9EdkQaKIXJQtgWV73bDuRElSTLOCDO4FZegLqCJxUylsSl43n+c8ZXzr781H7BYWGA/mr1t8Y
	niRMJPzemU5QaWePuYkcg8RRvlgGQZhDzuzmfl5mEC2nBBBu+VjQ1j56iY+41+BfRFdMzfFktDf
	YUNNzmAqqXO+bCT8lrxOM9qHTRK0fTRDIQ3gCNrjpvS989D6w2IQlJTd8lYt0yLNAnndBMBuUQ3
	n1Dya+VvhofYjJj9966CppVRbpdQ2A9cJ3rBQ4mwXWionywmiSoBK+KzM3vfc+TRk5NpHR+7HYw
	a+Qdm/XwSzYbxVPVCmJ6WY9XsB+9Lm4U8VZXaUe6a0l437HF0akbXpr2Go9CBBA/ihrE3U2Wsrh
	oGJZHCjNggyoDZguAQpOhTjfWtNDB5iaCK1N9zdQnPaF0BotKkqTKOPXVeiLuthfOhoEpTl0TvP
	i3RhQLP/7falTY7zvDRpGben4LA3tTjE5rvDRFVNxB0TjMP2sltPUeUlm5bY9I/z7RCZY7YEb6m
	vRcJuCZkouZ3KOfhQ4WoeWkh059Rq6g==
X-Received: by 2002:a05:600c:3ba3:b0:4bb:6118:4c9a with SMTP id 5b1f17b1804b1-4bb88819940mr657770165e9.30.1795883246973;
        Sat, 28 Nov 2026 08:27:26 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm529202045e9.1.2026.11.28.08.27.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:27:26 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 01/10] swtpm: upgrade 0.10.0 -> 0.10.2
Date: Sat, 28 Nov 2026 18:27:04 +0200
Message-ID: <5ecdb9a9f6c1e7fc89b4942b7d077bca227455d9.1795882913.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795882913.git.scott.murray@konsulko.com>
References: <cover.1795882913.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:27:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5560
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

