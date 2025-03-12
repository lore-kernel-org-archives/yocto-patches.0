Return-Path: <omri.sarig13@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC2CC28B2E
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 10:33:58 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web10.33631.1741775626560949948
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Mar 2025 03:33:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QDHlOnNS;
 spf=pass (domain: gmail.com, ip: 209.85.208.176, mailfrom: omri.sarig13@gmail.com)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a6bso69743451fa.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741775624; x=1742380424; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1V7Ej+ZwKCrxbObQW0py6PzlhdfDGdlyN4aeXhJlx/o=;
        b=QDHlOnNSP5DHFKLmmsVkHrqrAWXd+XkXVMGYeWPC26Qmzy6ps7n8ak0MmcUD4aaErU
         gKKf7259TqqNBgbB6zGX1jks/gC9ABj2zQ16q4XxmRcpPK143IqlSSBj9NJFK+cJVcIn
         edcRpT0Fo/TR5TLt0QJcpVpUTEXhIZPk0uWvrSpT4OBAEM0wzytnfcqTz9FMtUAr4e2q
         ri3BNthwgkZJPh5pLg0go3Bf/1kqujSMg5StowagLc0xCyJHiKnr5j1LdJtb42SKhJ9i
         sWthAQIzbl4Gyt3I51KW1vyrMlztMxy5NyTpkfsEVHjcQUwa4djk/dcG9AQnT5ksuAgf
         tosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775624; x=1742380424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1V7Ej+ZwKCrxbObQW0py6PzlhdfDGdlyN4aeXhJlx/o=;
        b=eF9LEc0yAjZflzYukUkcjMd6Ibvmq+OvmscuWXXfUEX44J9Ol9t215M8kOXWLXdcym
         q4I+FczUYcskH8PUPLniz5xgkZYBLTZ/pXbtNLDOl6x/2AwV++FLZLFLWWenflRI3rzO
         fdl2U9kGssCzSVi9x1oqU96MLgPIRs9LzfQ+jbwC90EQNEar3YFK4GgX7mu26i03wYnb
         728t9UUvZjo29VASlRKZpQ3k+SveNbStlAWWJQh3m5B8hdOlyuwwHD+9HF2WnCzOyJRZ
         dR7nQ+2bmyTzWLu85PzYovLCVxOrsAjn/SGgFAY7AEWaNm+OmhterPM+tPuCz3U8h+V3
         i6ew==
X-Gm-Message-State: AOJu0YzCrCXrAKT8z1v5tgno9BONXmQc65BtkJLOqrdIi9/evNfpPdKA
	8TPjmvfKWYFuy3BP9OfwUIxELcLmMwK3E03iZXAbIi4I+tu5AcQb3w6f7z3S
X-Gm-Gg: ASbGncuLcp19ujEvXRD8leYZg8zhRwJeoSfW1RVALCoovLrrpcLWMORaO2AOIJJhFdm
	K+TLWafgS9QBBra9OPCmbcL0yC+b8FaHzkIbn4Uu7t4CrfzrelVnFpr5pEtTDdsfcr5BaMVzHpr
	2D3ZzxTjax0jUCDzDuxk1CvUkqt6e2X3wxCaqmNzfTMEKcGuBBe/4BU/VHoulCm9Zi/BXTrPXo2
	ON0jV0ZezzkQy7lbjmOqjnM2A1tbxqlnLAWwErVqFyw7Z7C+ZfY8pBC/XcY2/7Avi4VdrRLu1je
	i8LSc+jHU4g5twCiGWtB5b5UQSninFcQEogQHwop964TmnfyDK6wD11+fxLteRh6rrwlHNBbZiY
	8vBuTyJCZLiH0BfSVF1eEKOv4V3E=
X-Google-Smtp-Source: AGHT+IH7/WuWzpNd0Rz7AbavoMsFtoLIlChdPaf8OPDPJ/VFjO6pHFkh7P31f9rE4bNxXnI12dULUQ==
X-Received: by 2002:a2e:a403:0:b0:30c:189d:a169 with SMTP id 38308e7fff4ca-30c189da6b0mr34424051fa.25.1741775624166;
        Wed, 12 Mar 2025 03:33:44 -0700 (PDT)
Received: from omsa-HP-EliteBook-840-14-inch-G9-Notebook-PC.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bfceebd49sm18030821fa.60.2025.03.12.03.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:33:42 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Omri Sarig <omri.sarig13@gmail.com>
Subject: [PATCH v2 3/3] oeqa/cases/tpm2: Add tpm2-pkcs11-tools sanity test
Date: Wed, 12 Mar 2025 11:32:41 +0100
Message-ID: <20250312103241.2526274-4-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312103241.2526274-1-omri.sarig13@gmail.com>
References: <20250312103241.2526274-1-omri.sarig13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 10:33:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1193

Add a very simple sanity test, which ensures that tpm2_ptool can run
without problems when the relevant package is available.

This test case is available here to help prevent future errors, where
the tool is unable to run after installation, due to missing
dependencies for example.

Contrary to other tests in the file, this test does not communicate with
the TPM module itself, it only ensures that the tool (tpm2_ptool) can be
loaded without any errors. Therefore, we don't need to depend on
anything other than having the package installed.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
 meta-tpm/lib/oeqa/runtime/cases/tpm2.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meta-tpm/lib/oeqa/runtime/cases/tpm2.py b/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
index 8e90dc9..c2e6dfa 100644
--- a/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
+++ b/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
@@ -67,3 +67,8 @@ class Tpm2Test(OERuntimeTestCase):
     def test_tpm2_swtpm_reset(self):
          (status, output) = self.target.run('swtpm_ioctl -i --tcp :2322')
          self.assertEqual(status, 0, msg="swtpm reset failed: %s" % output)
+
+    @OEHasPackage(['tpm2-pkcs11-tools'])
+    def test_tpm2_pkcs11_tools(self):
+        (status, output) = self.target.run("tpm2_ptool --help")
+        self.assertEqual(status, 0, msg="Module cannot be run with error: %s" % output)

