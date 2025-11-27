Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03681D111A8
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 15:48:18 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21520.1764258494741086296
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 07:48:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=TD6IjrSO;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A7F63C16A1C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 15:47:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 821FD60722
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 15:48:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2CBD102F294B;
	Thu, 27 Nov 2025 16:48:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764258491; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=hw/rl6q5LXmS4068G9BkFeKGo6T9D2Wu9xEU+kzZOrM=;
	b=TD6IjrSOieSv1ziH2gClWVrNqJkOoJ1J4KlJAJqvEC/oEyIECY+oUNoO9St+olfTW5nU3a
	6x8n45GRZ2fyP2RMyyFEgR8prAXXO2NfRrgcFg1sX3o4kCmRiorPu1t+VjV19/wCNMAuHF
	jHgd+y0yvU+vEFtUyncKgeCxqgbvlLeY19qSgU5DwElO90n+RAfhnYc2Aus6Y9GwFaXlRP
	HqB9UCTMuCcSAF0PZAdPO2b7xqIlzFzbEboS/tqhYbfLLIWkGJBkfsO9J9mzFbDkByL62X
	QCoHIYWcB+e1QNG3vnhkW063HTJ1a2YMgn6As7D6CLIoniKPvrTUSBlr15cb1A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 27 Nov 2025 16:48:04 +0100
Subject: [layerindex-web][PATCH RESEND] layerindex: branchcompare: add rST
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-branch-compare-rst-v1-1-4eaf3a66ea91@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3556;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=L+qyG8w8dZ/4dydiYdM7fXqBM3o9slyCwzgXlCwlHh4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpKHK7PN0htqtEnHZDt8zy1TOkN+dw38sJ968Lv
 xJOoB5nQ4SJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaShyuwAKCRDRgEFAKaOo
 NgUMD/4jVqAciRW0T1v9y/3lWjFM9qcuTAipAi846dfwH55L7PqdzTmC4NvqB3Xui1k0MFrlXF2
 K/lVMcwZMg+BSS0gy3/TMkt95QdsM+6PJ/TddokCExoTOPjShMHLmjFEEdIPhkjaYcOik3YxWQI
 zNF/qVAliuzDUhPPsvNvNofr35w8vdth5ve3SMCqd9avqP0nENagwNh6bCPsfbrqc0bQMjioGHF
 YWgKZ2SUDdRsCf7N4VXyGaemQM3Lfq/iGuK4QIuaCbkN3Ta6DJN8SrjmAlWMreUh8bqKwQmZrsm
 A04FyMf7DToSXCJa5m5ENJYKWKPeJZyww82hAWUdcJEyFFl0wyIq77Cc/ED2LZmugwinEgZnIzj
 hB1S2NJdqNaDQVnDcBSSAdKVHph9MO/MqwnUAqNRuEHCc13gu8ZXeDPGLxJyDigRtjBsgZzmDA1
 ES+mD39BS9dyRDffOMq45Izv1tagu8g5y6hHBP2v9dL06RaDmW9XSeBcGydTeRc8V3rLYT4wDL7
 JyU7zxlf0Zok5XCiB+n/pW1nG4K8dtMcTkRhvWkmyxOj5g3l6Z/vGacSCTWqIRNcKXQfuJwiedT
 pG1HffCcBxDRCJJllhkPM0t3m5VczOKY29ml3yWlLugpBq4S8BTmncZXTA16M/ecKk4ieIPWI29
 wRMIcFzIVZc5LuQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 15:48:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2720

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
-- 


