Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E56CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 15:45:18 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21454.1764258307317974577
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 07:45:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=VilQeg8c;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 384B81A1DB7
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 15:45:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 087E560722
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 15:45:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36ECC102F294B;
	Thu, 27 Nov 2025 16:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764258304; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=GhTwHcFV7jg3/4AT8E4SkzJUpBaM5yjG7uslBY5FiNA=;
	b=VilQeg8cu9UZtJ/cLC5Y+Rzc+gJP2DqgDz8MT2vFlY5g0Po9y6DqgzIuZKM4Kica3LUCxS
	yieMwublzLbQHxCoDFAS1DORciN4JaZteMf8kXkJAjGSZ6EhJgna5i0snyTte0/0zuEiru
	2+C5QQAPgBvDIul4XDF27ncFG4QUmJzELfKIUzPRTgWi9NudDUf7kv0xkRbm4R4XK6CTGT
	arHcdluRfQOvUU/AI9bqY+7rL+ZHmt+8FkKZ0zyFRZ3qqAMsLMM4iyLV3vqabiW/2e637v
	j7zr3MBd8vmEktObasG+22e8bE4tfqaiK50aw2vaPqWr6s3PKnFOUirVbQfUBw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 27 Nov 2025 16:44:58 +0100
Subject: [PATCH] layerindex: branchcompare: add rST format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-branch-compare-rst-v1-1-70c00ab5c149@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPlxKGkC/yXMQQ6CMBBG4auQWTuJbQMSr2JclPIDQ2IhM2hMC
 He36vJbvLeTQQVG12onxUtMllzgThWlKeYRLH0x+bOvnfMX7jTmNHFaHmtUsNrG8E0ILTD0daA
 SropB3r/p7f63PbsZafue6Dg+2Edgx3YAAAA=
X-Change-ID: 20251127-branch-compare-rst-e26338eefd53
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3551;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=zfHcyNJVx7M7H6JNglpHDjnqvL/dAed5bsZG34XJUL0=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpKHH/eV2sPaMbCXXyoKCgkRUI0n0fixKbVWLGf
 2hrS3pGps2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaShx/wAKCRDRgEFAKaOo
 NrK5D/4rJD3BCliZn8tkZjbBpCEmRNBAmUmjscuO4Yjcoc4TDAmMo2gOubRvjFkl6FHQ/87updf
 SGLUcsEJifBGAEdE3OoE6YF4l3zl8PWbvRvLDZ8b8zmsZTCTCzciTpfoaYxmVtUNQIjvJ8iidwC
 /tBZAnBfmnHBW4+DRYEidXpBh0pMHQgXp0NX/ENKSKPITCCWSkxJj3z/c7jpk1NBz/z6UXvdR1z
 ZNggYHoOJ377jnmPqzcTvCyv0sqBWpMALpOdNLf1iaj8MlNY71N1IcZbgSlS+rfwVwaHABevl2/
 RB7EANwD+qJxMXcCOD3rSUFTtn+cryHMcN8GRt76kUA3Zux2raNOlyLQoNEEvVptBLzAw0QL+B6
 //kTDSroljTken6QEg6Z4V2dwrBm9BA2BW9+KuoPdjTGaStWqhvRo8SwbmEbib9j+1IL0QwCZwV
 SNzn2ffaGDnVHhmQtrWkIDExvSSAI/poSwAbF9+cNqy8+Nkax1++jtjHWgSy3qlBANhUHoXBhFW
 WMvMjBqHsLhy3XQnYg3uMb327CRbhLkDQ2V8JKcLpDlD99swoATnFVWuy1NEO7bOZFKngbH5rEm
 uztWfY7o0qR3smukYCJoHGgPAmdFVLRZ/V0DMj8k+PLxg+yXTlYnZ1zZoHNqxEqhIfF5BZI9ia/
 Gq4GJX1rtTq3rJQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 15:45:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2718

Add a new rST output format for the branch comparison tool. This can be
used to help write the Yocto Project release notes.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
An existing example (that I formatted manually at the time):
https://git.yoctoproject.org/yocto-docs/tree/documentation/migration-guides/release-notes-5.2.rst?id=79cd33b06e87c04e4f873a5afd9d53714bc5047f#n876

HTML output: https://docs.yoctoproject.org/5.2.4/migration-guides/release-notes-5.2.html#recipe-upgrades-in-yocto-ver
---
 layerindex/urls.py                         |  5 +++++
 templates/layerindex/branchcompare.html    |  1 +
 templates/layerindex/branchcompare_rst.txt | 35 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/layerindex/urls.py b/layerindex/urls.py
index 80ceaa7..3b95a88 100644
--- a/layerindex/urls.py
+++ b/layerindex/urls.py
@@ -195,6 +195,11 @@ urlpatterns = [
             content_type='text/plain; charset=utf-8',
             template_name='layerindex/branchcompare_plain.txt'),
         name='branch_comparison_plain'),
+    re_path(r'^branch_comparison_rst/$',
+        BranchCompareView.as_view(
+            content_type='text/plain; charset=utf-8',
+            template_name='layerindex/branchcompare_rst.txt'),
+        name='branch_comparison_rst'),
     re_path(r'^recipe_deps/$',
         RecipeDependenciesView.as_view(
             template_name='layerindex/recipedeps.html'),
diff --git a/templates/layerindex/branchcompare.html b/templates/layerindex/branchcompare.html
index 56b2310..93ac801 100644
--- a/templates/layerindex/branchcompare.html
+++ b/templates/layerindex/branchcompare.html
@@ -151,6 +151,7 @@
 
     <span class="pull-right">
     <a class="btn btn-default" href="{% url 'branch_comparison_plain' %}?{{ request.GET.urlencode }}"><i class="glyphicon glyphicon-file"></i> Plain text</a>
+    <a class="btn btn-default" href="{% url 'branch_comparison_rst' %}?{{ request.GET.urlencode }}"><i class="glyphicon glyphicon-file"></i> rST</a>
     </span>
 
 
diff --git a/templates/layerindex/branchcompare_rst.txt b/templates/layerindex/branchcompare_rst.txt
new file mode 100644
index 0000000..1e61848
--- /dev/null
+++ b/templates/layerindex/branchcompare_rst.txt
@@ -0,0 +1,35 @@
+From {{ from_branch }} to {{ to_branch }} (layers: {{ showlayers_text }})
+
+Added
+-----
+
+.. list-table::
+   :widths: 30 70
+   :header-rows: 1
+
+   * - Recipe
+     - Version(s)
+{% for recipe in added %}   * - ``{{ recipe.pn }}``
+     - {% for rv in recipe.to_versions %}{{ rv.pv }}{% if not forloop.last %}, {% endif %}{% endfor %}
+{% endfor %}
+
+Changed
+-------
+
+.. list-table::
+   :widths: 20 40 40
+   :header-rows: 1
+
+   * - Recipe
+     - Previous version(s)
+     - New version(s)
+{% for recipe in changed %}{% with pv_changed=recipe.pv_changed %}   * - ``{{ recipe.pn }}``
+     - {% for rv in recipe.from_versions %}{{ rv.pv }}{% if rv.srcrev and not pv_changed %} ({{ rv.srcrev|truncatechars:13 }}){% endif %}{% if not forloop.last %}, {% endif %}{% endfor %}
+     - {% for rv in recipe.to_versions %}{{ rv.pv }}{% if rv.srcrev and not pv_changed %} ({{ rv.srcrev|truncatechars:13 }}){% endif %}{% if not forloop.last %}, {% endif %}{% endfor %}
+{% endwith %}{% endfor %}
+
+Removed
+-------
+
+{% for recipe in removed %}-  ``{{ recipe.pn }}``
+{% endfor %}

---
base-commit: 459e8d6f1f18528a835513f12dffcc999c8f7fb5
change-id: 20251127-branch-compare-rst-e26338eefd53


