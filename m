Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743A7CA6007
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 14:28:01 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16612.1791469673228779376
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Oct 2026 07:27:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sjlqA+q/;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: ticotimo@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b001cd92bso2806690f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469671; x=1792074471; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Da5dPwfnVxtUBjJXFmViAgtS1c7dBiOXEw3O2ubE4wY=;
        b=sjlqA+q/d//VHvRSzt4eKuGVCIkMhvohTA8FgposetDBbMi4VOdeYeENBAMp8DCzR3
         Xghg5gGbCUGHQxS3xNGPSqtXgbFPe5+Sh2CcbYJSgAHkFMEbQdEuvSxaAX0knGKWHqHv
         cQHG98VvRc42WGPrH9FKZ7ta58AvumDsiCAC07v3T02miTtbdGRIF6GYSZQB/DgCxPAo
         jw9bQCFsN3Gi8ouc5SpU8gxJ9X/y1WKx1AVw7dYboFCwA4P2Lo54YgNGaOnUcfgaDFgC
         qDyhnYrG6NFLF/JSQ3TWZOi30DUnP9Vu1loySzd1qb7dCZPds/1O/mMWENI2EwrOldjw
         oJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469671; x=1792074471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Da5dPwfnVxtUBjJXFmViAgtS1c7dBiOXEw3O2ubE4wY=;
        b=2aBlWC53PskvX1BjMUFOuKNEF8mUGJxT4h+W2VqEctsFjC7FMokzB2sJ6v+H0mOorM
         O3JjD2nNi3owGZ2qT8H8idqE9s9d2XU0dsCmhDATJhl1exc7Z/tZA1igiVNv7PcSmyir
         3oS9XL8ycRSBJkEbwOMHHgBZlPMm+bcHW04wENgISGYn4yqflksk1GL91M++SaGq36vO
         gdTXodRSPvk4BM5dwURgZXYJLdruyNgXrckCHokDkR+v6/kI/oHKtsK3AeVmhzy5zVRe
         RqJ92UlJz4zBh933U3OK0Ptpo2jOlK8Iagut5SfFAtmZA94cY3X5x3zTpRKA8a6zB1p2
         JeMg==
X-Gm-Message-State: AFq9FYIV9Xy9pYGIoE1MX8aiuGXuuDfZjCY+ZnIlpDEmfUgK+PwGZ3I1
	sZ+H0fIhUoGX9m8KWkE9OeWay2p32us+DLeSvkanJdDjkpUKUjaQHO11kmDNaO4L
X-Gm-Gg: AYBFou3pGbmipVfd95xNdmPptTpfROxqHfoaB/MEhfIuVgiT45/DiU3qMiOxNU6Um7v
	J/2RK6cCpQ6J8MY9RDV6WxCaS37+L0KqIZjiLFIZeeJ1CmJZM4EEJ6usLwTFPXrz4fC2urDNppa
	/0dFmf/wA5SFRx29AJMwoVacW9+ts2m0+F9JQek23pW51ZBzlOeuhdaSp6YEmbh9JWoGDjqny7v
	XHLUKgeHOfDa2yeaG4bti4rpWOOw3uaXQe7kNdrXfDAdTuk9T8wGmzsrOhMdA9qBSbvAfhgH3wR
	k17RabI0zK2MYWtgPtzlh5sRaYWcUfwO0Q1yv0PV3UPjCrOKbCcjbxIHMTJFsmf3iUMgAZtgJJG
	m0q57M05fQCa+E+zp9aM4n8DrcQa4dg1B5V17lLP/QtYxCsgb6vww3pkwn8mjKGIz/qBpiCQixp
	/7YFTz7CoeMQ/cGicjOZE9nsfgkD+BB+SBECCowwN4Xdb91KOtwHun/MY8gmi1S9paoyW2ORXe/
	k9eIteSffo95MDlDWOWlQ8bvgFMZ91RA+7anRvL8SE5+tdhpQ==
X-Received: by 2002:a5d:5584:0:b0:485:8c16:5ee9 with SMTP id ffacd0b85a97d-48c72789c57mr8172362f8f.35.1791469670817;
        Thu, 08 Oct 2026 07:27:50 -0700 (PDT)
Received: from localhost.localdomain (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2014asm11491958f8f.38.2026.10.08.07.27.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 07:27:49 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>,
	Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/2] layerindex/views: fix publishing layers with multiple branches
Date: Thu,  8 Oct 2026 16:27:37 +0200
Message-ID: <20261008142738.29958-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 14:28:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4996

From: Michael Halstead <mhalstead@linuxfoundation.org>

publish_view assumed a layer had exactly one branch: get_object_or_404()
on LayerBranch raised MultipleObjectsReturned (HTTP 500) for any layer
with more than one, and passing the Branch object rather than its name to
reverse() produced a mangled URL when the branch had a short_description.

Collect active maintainers across all of the layer's branches, keyed by
email address so the greeting names and the recipient list cannot diverge
and the ordering is stable between sends, and list every branch the layer
is indexed on in the email body. A layer with no branches or no active
maintainers is now published without an email rather than returning 404.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py                   | 65 ++++++++++++++++-----------
 templates/layerindex/publishemail.txt |  6 ++-
 2 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/layerindex/views.py b/layerindex/views.py
index c671cc5..4f8e64e 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -31,7 +31,7 @@ from django.db.models.query import QuerySet
 from django.db.models.signals import pre_save
 from django.dispatch import receiver
 from django.http import Http404, HttpResponse, HttpResponseRedirect
-from django.shortcuts import get_list_or_404, get_object_or_404, render
+from django.shortcuts import get_object_or_404, render
 from django.template.loader import get_template
 from django.utils.decorators import method_decorator
 from django.utils.html import escape
@@ -376,31 +376,44 @@ def publish_view(request, name):
 
     if getattr(settings, 'SEND_PUBLISH_EMAIL', True):
         layeritem = get_object_or_404(LayerItem, name=name)
-        layerbranch = get_object_or_404(LayerBranch, layer=layeritem)
-        layer_url = request.build_absolute_uri(reverse('layer_item', args=(layerbranch.branch, layeritem.name)))
-        maintainers = get_list_or_404(LayerMaintainer, layerbranch=layerbranch)
-        from_email = settings.SUBMIT_EMAIL_FROM
-        subjecttext = get_template('layerindex/publishemailsubject.txt')
-        bodytext = get_template('layerindex/publishemail.txt')
-        maintainer_names = [m.name for m in maintainers]
-
-        # create subject from subject template
-        d = {
-            'layer_name': layeritem.name,
-            'site_name': request.META['HTTP_HOST'],
-        }
-        subject = subjecttext.render(d).rstrip()
-
-        #create body from body template
-        d = {
-            'maintainers': maintainer_names,
-            'layer_name': layeritem.name,
-            'layer_url': layer_url,
-            'help_contact': _get_help_contact(),
-        }
-        body = bodytext.render(d)
-
-        tasks.send_email.apply_async((subject, body, from_email, [m.email for m in maintainers]))
+        layerbranches = list(LayerBranch.objects.filter(layer=layeritem).select_related('branch'))
+
+        # Collect active maintainers across all branches of this layer, keyed by
+        # email so names and addresses stay in step and the order is stable.
+        maintainers = {}
+        for m in LayerMaintainer.objects.filter(layerbranch__layer=layeritem,
+                                                 status='A').order_by('name', 'email'):
+            maintainers.setdefault(m.email, m.name)
+
+        if layerbranches and maintainers:
+            branch_info = [{'branch': lb.branch.name,
+                             'url': request.build_absolute_uri(
+                                 reverse('layer_item', args=(lb.branch.name, layeritem.name)))}
+                            for lb in layerbranches]
+
+            # Prefer master as the primary link, otherwise the first branch
+            primary = next((b for b in branch_info if b['branch'] == 'master'), branch_info[0])
+
+            from_email = settings.SUBMIT_EMAIL_FROM
+            subjecttext = get_template('layerindex/publishemailsubject.txt')
+            bodytext = get_template('layerindex/publishemail.txt')
+
+            d = {
+                'layer_name': layeritem.name,
+                'site_name': request.META.get('HTTP_HOST', ''),
+            }
+            subject = subjecttext.render(d).rstrip()
+
+            d = {
+                'maintainers': list(maintainers.values()),
+                'layer_name': layeritem.name,
+                'layer_url': primary['url'],
+                'branches': branch_info,
+                'help_contact': _get_help_contact(),
+            }
+            body = bodytext.render(d)
+
+            tasks.send_email.apply_async((subject, body, from_email, list(maintainers.keys())))
 
     return _statuschange(request, name, 'P')
 
diff --git a/templates/layerindex/publishemail.txt b/templates/layerindex/publishemail.txt
index 5d703d8..068eca1 100644
--- a/templates/layerindex/publishemail.txt
+++ b/templates/layerindex/publishemail.txt
@@ -3,7 +3,11 @@ Hi {{ maintainers|slice:":-1"|join:", "}}{% if maintainers|length > 2 %},{% endi
 You are listed as the {% if maintainers|length > 1 %}maintainers{% else %}maintainer{% endif %} for the new layer, {{ layer_name }}. This layer has now been published. You can view it at the following URL:
 
  {{ layer_url }}
-
+{% if branches|length > 1 %}
+This layer is indexed on the following branches:
+{% for b in branches %}
+ {{ b.branch }} - {{ b.url }}{% endfor %}
+{% endif %}
 If you need to make changes to this layer's entry in the index in the future, create an account (using this email address) if you haven't already, and you should then be able to click on "Edit layer" on the layer's detail page and make the desired changes. If you need any assistance please contact {% if help_contact.first_name and help_contact.last_name %}{{ help_contact.first_name }} {{ help_contact.last_name}}{% else %}{{ help_contact.username }}{% endif %} <{{ help_contact.email }}>.
 
 Thanks!
-- 
2.56.0


