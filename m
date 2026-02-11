Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ADBECD6E9
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 19:55:59 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27916.1770839753202055438
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Feb 2026 11:55:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fvyQOLTg;
 spf=pass (domain: gmail.com, ip: 209.85.215.179, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c5513f598c0so2618704a12.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 11:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770839752; x=1771444552; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo+ZB0clgwRrPqKB0WVvdRlOwzGd3hOadMarlpBcM+Q=;
        b=fvyQOLTglhu7rfXOTKQEUMbRQJWSl9VD3is7Q8qQOR/35XSk4kDahkeVayBgM1jvUh
         rMyg5QHNlruJhZpSUITsior3J8eYnvvH5gO8I12ibur2Wep1+zXTBZB5WZjmSgdlg4qz
         xyqu2S2k+xqO5qkApv93XmcBvgJHqVJ5W+2M7zOZH5zpkp7ik8l96Uj7MljSu1pOgs1k
         GeaJoRlbYyB11t9IMXei81DEMlwEtu5UawtcnirBibNTeOfj84sJW0pMsIsDB+R535rK
         W/yYCBifC1rVQaUI1WmdRaCM5g1PdyJC60zxl8yQB2pnjGdpYuGcCI1SiIQrCokiaD3L
         J49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770839752; x=1771444552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bo+ZB0clgwRrPqKB0WVvdRlOwzGd3hOadMarlpBcM+Q=;
        b=N7NwU+i8clUY8Y5CORY+51npgl06S2p0AeZikWbDn1SnksQRroIQnTknHnnOj5JoaB
         AKyVEbWXMWPgweO88hN/PaSDIvE4aIdZpAdQ40HNJDBJ+o/THFcGDEMtdtdRZXAT0neu
         0L0eUWxFt1+Q7rNeuVVCotpaWXXhzy2LU1yadPCOQ0zdnPg5iwEjUN0Z/hTYJox0wJNc
         l9neHw0nfnlE3sCsArH/zLwpGy4NTIOkReH26PSIrCk1rPECDL0VA8tZ+eZnOp7IPLEz
         KPffGum/h/7E3hw+yw7t7YsdG5sqE0vVTS+WcJOJ+mcYzeolHiM61dA6jTIZvguBfqE5
         2xWg==
X-Gm-Message-State: AOJu0YxUfDWjucJ7lmKdqcFlJfXPDZne9zxFW7rq2dX8IKFhFUcRYY/U
	b+dyD+L6kDuKPOcHhO29bA67uZ2MDhZzqnTOuhoNyS0HQEqflkxEstbiiDVZhg==
X-Gm-Gg: AZuq6aJWONjxlCrWbbEXbapGkzjWVyTAU/srMorTgiH7R7593hTqsMZyTT4NyS/oC9V
	A13rpxkwdvd7RFZqDn/jqLqccRV5NbvQ+QZ8CjziVho7ApSD62xfRsYtABP+PYaWCqA9Xld558p
	EUSfo9mLx2BPgx/eQyfTRZtOWhStiNsZGED5eXy4v70aXMt4qitN0RXXnyh9uQpY9AT++BfW7MF
	kr+mMYdvyXqhBrsNOnToo227pu46fUTKJOp8GKdhHzY3o8xACrd4yBuHSFpsf6r4Tww3rI20pfL
	YCO2g5kiRg5SjIJnwvFosA80AsBuwVVUvBhLBXuW6sfCuU1tZhWh3Bv7XzHfrFHLVHhXCG6EvEU
	kPns61EapH+ImGjnfog6/z1W3rf2HkxBjKqGZ+FUK+xaQ+N9h+A2IMHm9G2Ff/cbtGWivDAOsIc
	o39Y9lNjFz5Hgg2hQJorP1fB4WQgclWaCmkEKYQvqWKOFGKK49LFRxE4giwhFPFzlAugHUcTsIN
	PscH/aZXBGe413X3mtjfas=
X-Received: by 2002:a17:90b:35ce:b0:356:268f:4fc with SMTP id 98e67ed59e1d1-3568f300efemr483692a91.11.1770839752067;
        Wed, 11 Feb 2026 11:55:52 -0800 (PST)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e7d621esm2810293b3a.32.2026.02.11.11.55.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Feb 2026 11:55:51 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/4] BranchComparison: add CSV output option
Date: Wed, 11 Feb 2026 11:55:35 -0800
Message-ID: <20260211195536.10278-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260211195536.10278-1-tim.orling@konsulko.com>
References: <20260211195536.10278-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 19:55:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3216

Add a new template, URL and button for CSV text file output.
This makes it easier to consume the BranchComparison for automation
or other usage, such as in a spreadsheet.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/urls.py                         |  5 +++++
 templates/layerindex/branchcompare.html    |  1 +
 templates/layerindex/branchcompare_csv.txt | 11 +++++++++++
 3 files changed, 17 insertions(+)
 create mode 100644 templates/layerindex/branchcompare_csv.txt

diff --git a/layerindex/urls.py b/layerindex/urls.py
index 3b95a88..7555907 100644
--- a/layerindex/urls.py
+++ b/layerindex/urls.py
@@ -200,6 +200,11 @@ urlpatterns = [
             content_type='text/plain; charset=utf-8',
             template_name='layerindex/branchcompare_rst.txt'),
         name='branch_comparison_rst'),
+    re_path(r'^branch_comparison_csv/$',
+        BranchCompareView.as_view(
+            content_type='text/csv; charset=utf-8',
+            template_name='layerindex/branchcompare_csv.txt'),
+        name='branch_comparison_csv'),
     re_path(r'^recipe_deps/$',
         RecipeDependenciesView.as_view(
             template_name='layerindex/recipedeps.html'),
diff --git a/templates/layerindex/branchcompare.html b/templates/layerindex/branchcompare.html
index 93ac801..83561fd 100644
--- a/templates/layerindex/branchcompare.html
+++ b/templates/layerindex/branchcompare.html
@@ -152,6 +152,7 @@
     <span class="pull-right">
     <a class="btn btn-default" href="{% url 'branch_comparison_plain' %}?{{ request.GET.urlencode }}"><i class="glyphicon glyphicon-file"></i> Plain text</a>
     <a class="btn btn-default" href="{% url 'branch_comparison_rst' %}?{{ request.GET.urlencode }}"><i class="glyphicon glyphicon-file"></i> rST</a>
+    <a class="btn btn-default" href="{% url 'branch_comparison_csv' %}?{{ request.GET.urlencode }}"><i class="glyphicon glyphicon-file"></i> CSV text</a>
     </span>
 
 
diff --git a/templates/layerindex/branchcompare_csv.txt b/templates/layerindex/branchcompare_csv.txt
new file mode 100644
index 0000000..d407ae3
--- /dev/null
+++ b/templates/layerindex/branchcompare_csv.txt
@@ -0,0 +1,11 @@
+{# Header #}
+recipe.pn,recipe.pv.{{from_branch}},recipe.pv.{{to_branch}}
+{# Added #}
+{% for recipe in added %}{{ recipe.pn }},,{% for rv in recipe.to_versions %}{{ rv.pv }}{% if not forloop.last %}{% endif %}{% endfor %}
+{% endfor %}
+{# Changed #}
+{% for recipe in changed %}{% with pv_changed=recipe.pv_changed %}{{ recipe.pn }},{% for rv in recipe.from_versions %}{{ rv.pv }}{% if rv.srcrev and not pv_changed %},({{ rv.srcrev|truncatechars:13 }}){% endif %}{% if not forloop.last %}, {% endif %}{% endfor %} -> {% for rv in recipe.to_versions %}{{ rv.pv }}{% if rv.srcrev and not pv_changed %} ({{ rv.srcrev|truncatechars:13 }}){% endif %}{% if not forloop.last %}, {% endif %}{% endfor %}
+{% endwith %}{% endfor %}
+{# Removed #}
+{% for recipe in removed %}{{ recipe.pn }},,
+{% endfor %}
-- 
2.50.1 (Apple Git-155)


