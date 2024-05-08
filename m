Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9741C19F4F
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:53 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web10.15800.1715182305191609449
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=diXof/xt;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.167.50, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51fdc9af005so6880623e87.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182303; x=1715787103; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iyT614jeRpGD2Ha3f7FgN8s0MjRZ6MU2LQIUroY9Xgc=;
        b=diXof/xtfXRSHALlkQuXp5J5tIL3NEB5dfiGEmOpjE/o7vmY4BJaaQIzrpj22YFvYE
         gNCQaMqFD6bCsGli+DXbWY25XtdxggZ5oZf3aDbVkfbo5+LNArZFwGqEcmw+LY8znSSN
         S82cGg+o5CKYoTKDVC9NLNbJVkZo0Lg9nJMZyljLf9hEXMnzJ9LRBDpNAO3rvpScA+6y
         38UO42w7tQwr/WQdI1rfcc4MGWRnK+EC18XYgBLX7H4sGvyhJ4hWOFDxA5xIdrd9hGV0
         Ds4FJgEhUtE9WlXo0nRYlBcprgtKr0nlfZbHHXiUXbuzKvMnXqz1CTodTQs/i9nva/ii
         yBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182303; x=1715787103;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyT614jeRpGD2Ha3f7FgN8s0MjRZ6MU2LQIUroY9Xgc=;
        b=kanua8baJz52X0yQaySIMZTjMqZpN2lRuYnQq0MQENsBmaGRHnRbRtmtJWHvv3OcKd
         LOzhL5L947MbzK6TvjAZyvs1wvVW2FXUvdtRmi3jeTiMYSUIeBpOQS0kPWumOoZUDVb0
         MAtlM9NAsDIQ+A3LvgYKDUUsKs0cbgnymHVP+V0bGOglIr0JPQsv2ZJJRqi5fOu/LgZQ
         6jFLFhxl0SShQ/r0X6bp39oyRkh9qTXE+AoYiPd55Ul+lqRLQQ3/9gGbppR5VIh4F3Sa
         3t+f0UDu0v9iweEQ8gm2W8ezswVRQdfQ7TH+KeOPoUg1Mu1AmJjPk7lcB6rv4blXQwC3
         INLQ==
X-Gm-Message-State: AOJu0YzeoFRU7gWa0qYfnZmTHDVAhkOz0kaiwgWsXoVbxnDKm19RW86V
	Xqrm1bYppEsZGmicMALzD7xUnfoa4DlNnkRs3fDsxyCZeKBq2NDYEIvI/2WiXeiTCfwqmcOrg/B
	0
X-Google-Smtp-Source: AGHT+IFCSdALdbtU3IxTMF+KtFL5zx32b201uI+nYEKsNMj6FkdkJFz5LwMNN2TXcMZp3MNElV3I8w==
X-Received: by 2002:ac2:5f01:0:b0:51f:c112:9d7d with SMTP id 2adb3069b0e04-5217c854dbdmr2143132e87.41.1715182303170;
        Wed, 08 May 2024 08:31:43 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:43 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 07/12] index.html: add description to upstream status section
Date: Wed,  8 May 2024 17:31:22 +0200
Message-ID: <20240508153131.94270-8-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508153131.94270-1-ninette@thehoodiefirm.com>
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/98

From: Alex Feyerke <hello@alexfeyerke.com>

Adds a collapsible details section with explanations of each upstream status, moves chart out of section element as before.

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
---
 patch-status/index.html | 138 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 4 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 30f1cef0..aacc6496 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -34,6 +34,31 @@ SPDX-License-Identifier: MIT
       display: flex;
     }
 
+    dl {
+      display: grid;
+      grid-template-columns: auto auto;
+      color: var(--pico-h5-color);
+      margin-inline-start: 1.75em;
+      margin-block-start: 1em;
+    }
+
+    dt:hover,
+    dt:hover+dd,
+    dt:has(+ dd:hover),
+    dd:hover {
+      filter: brightness(15%);
+    }
+
+    @media (prefers-color-scheme: dark) {
+
+      dt:hover,
+      dt:hover+dd,
+      dt:has(+ dd:hover),
+      dd:hover {
+        filter: brightness(150%);
+      }
+    }
+
     details {
       margin-bottom: 0;
     }
@@ -192,15 +217,120 @@ SPDX-License-Identifier: MIT
     </section>
 
     <section>
-      <h3>Patch Upstream-Status Counts (OE-Core meta directory)</h3>
-      <div id="upstream_status_chart" style="height:400px;"></div>
+      <h2>Patch Upstream-Status Counts (OE-Core meta directory)</h2>
+      <p>
+        The following two graphs provide insights into the status of patches in the OE-Core meta directory with respect to their upstream status.
+        The upstream status of a patch refers to its relationship with the original source or upstream project from which the patch originates.
+      </p>
+
+      <details>
+        <summary>
+          Upstream status categories explained
+        </summary>
+        <dl>
+          <dt><strong>Accepted</strong>:</dt>
+          <dd>
+            <p>The patch has been accepted upstream, meaning it has been applied to the original source code repository from which it originated.</p>
+            <p><em>A high count of accepted patches indicates successful contributions and integration of changes into the upstream project.</em></p>
+          </dd>
+
+          <dt><strong>Backport</strong>:</dt>
+          <dd>
+            <p>The patch has been backported from a newer version of the software or a different branch to an older version or a specific branch.</p>
+            <p><em>Backported patches show efforts to apply fixes or features from newer versions to older versions or specific branches.</em></p>
+          </dd>
+
+          <dt><strong>Deferred</strong>:</dt>
+          <dd>
+            <p>The patch has been postponed or deferred for later consideration or implementation.</p>
+            <p><em>Deferred patches might indicate areas where further review or discussion is needed before applying the patches upstream.</em></p>
+          </dd>
+
+          <dt><strong>Inappropriate</strong>:</dt>
+          <dd>
+            <p>This status indicates that the patch is deemed inappropriate for upstream inclusion.</p>
+            <p><em>High counts of inappropriate patches might indicate a need for better review processes or clearer guidelines for contributions.</em></p>
+          </dd>
+
+          <dt><strong>Submitted</strong>:</dt>
+          <dd>
+            <p>
+              The patch has been submitted upstream but hasn't received a definitive response yet.
+              It’s a transitional state between "Pending" and "Accepted" or "Rejected". Patches in this state are awaiting review and acceptance or rejection by upstream maintainers.
+            </p>
+            <p><em>Submitted patches reflect ongoing contributions to upstream projects. A high number of submitted patches might indicate active engagement with upstream maintainers.</em></p>
+          </dd>
+
+          <dt><strong>Pending</strong>:</dt>
+          <dd>
+            <p>The patch is pending review or has not yet been applied upstream.</p>
+            <p><em>High counts of pending patches might suggest a backlog in the review process or challenges in getting patches accepted upstream.</em></p>
+          </dd>
+
+          <dt><strong>Denied</strong>:</dt>
+          <dd>
+            <p>The patch has been rejected upstream, often due to conflicts, incompatibilities, or not meeting project standards.</p>
+            <p><em> Rejected patches could signify issues with patch quality, conflicts, or discrepancies between the patch and upstream requirements.</em></p>
+          </dd>
+
+          <dt><strong>Total</strong>:</dt>
+          <dd>
+            <p>The total count of patches in the OE-Core meta directory, regardless of their upstream status.</p>
+            <p><em>This provides context for the distribution of patches across different statuses.</em></p>
+          </dd>
+        </dl>
+      </details>
     </section>
 
+    <div id="upstream_status_chart" style="height:400px;"></div>
+
     <section>
-      <h3>Patch Tag Error Counts (OE-Core meta directory)</h3>
-      <div id="malformed_chart" style="height:400px;"></div>
+      <h2>Patch Tag Error Counts (OE-Core meta directory)</h2>
+      <p>The Patch Tag Error Counts graph shows the statuses "Malformed Upstream-Status" and "Malformed Signed-off-by" to provide insight into the quality and completeness of patches in the OE-Core meta directory.</p>
+      <details>
+        <summary>
+          Malformed status categories explained
+        </summary>
+        <dl>
+          <dt><strong>Malformed Upstream-Status</strong>:</dt>
+          <dd>
+            <p>This category indicates patches with improperly formatted or missing upstream status tags.</p>
+            <p>A malformed upstream status could be a result of missing or incorrectly formatted tags such as "Upstream-Status:", which is a common tag used to specify the status of the patch upstream.</p>
+            <p>Patches with malformed upstream status might not be properly tracked or considered for upstream inclusion, as they lack necessary metadata for review.</p>
+            <p>
+              <em>
+                High counts in this category might indicate issues with patch submission processes or lack of adherence to patch submission guidelines.
+                These patches might be at risk of being overlooked or rejected during the review process due to incomplete metadata.
+              </em>
+            </p>
+          </dd>
+          <dt><strong>Malformed Signed-off-by</strong>:</dt>
+          <dd>
+            <p>
+              This category represents patches with improperly formatted or missing "Signed-off-by" lines.
+              The "Signed-off-by" line in a patch is a tag that signifies the authorship and acknowledgment of the patch.
+              A malformed "Signed-off-by" line could be due to missing or incorrectly formatted authorship information.
+              Properly formatted "Signed-off-by" lines are essential for maintaining authorship attribution and legal compliance.
+            </p>
+            <p>
+              <em>
+                This category reflects issues with patch authorship and acknowledgment.
+                Patches with malformed "Signed-off-by" lines might lack proper attribution, which can lead to confusion about ownership and legal compliance.
+                Such patches might require additional verification or correction before being considered for inclusion.
+              </em>
+            </p>
+          </dd>
+          <dt><strong>Total</strong>:</dt>
+          <dd>
+            <p>The total count of patches in the OE-Core meta directory, regardless of their upstream status.</p>
+            <p><em>This provides context for the distribution of patches across different statuses.</em></p>
+          </dd>
+        </dl>
+      </details>
     </section>
 
+    <div id="malformed_chart" style="height:400px;"></div>
+
     <section>
       <h3>Recipe Count (OE-Core meta directory)</h3>
       <div id="recipe_chart" style="height:400px;"></div>
-- 
2.39.3 (Apple Git-145)


