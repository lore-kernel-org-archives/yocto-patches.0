Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3454AC021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 11:00:06 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.86256.1740394804538243118
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Feb 2025 03:00:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=LEI20xQH;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2065044216;
	Mon, 24 Feb 2025 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740394803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFBM3goxg2lu/sbfq+l/7k/MFz8T6IhjnLj7HWn6jVM=;
	b=LEI20xQHxopjQTCryPRWoiheiCY0JsjROpROJ8wtEq7Aabhz+HAjxgi/1PGi5Wn242dmhz
	Q7S8SmCmBtOxOCWgfHBnoaaufhgKosP1B8Nf2J1VS1U7O9stfwm+q/hyrMF/NJ83+C02Wx
	w9jn6B3o8OgItQgHrWyLEom+K3NaH4E9E7GdyG55ixvdsA2mmo/6ahuEqUgBCuUD10eVm3
	wci+whWWpgN4jPE+zzx3g89L8FE8XTMHFCPIfLs8YMpf7M4ZQNfSXmpFp8aEanJdiVbr9z
	vT1owcDFoJhHr9fCmX/6KrXgUNzgYoq7WvyABV+xd5LlOI8XnmNys36y+bis3Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 24 Feb 2025 11:59:32 +0100
Subject: [PATCH layerindex-web 2/2] layerindex: Allow staff to set Yocto
 compatibility
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mathieu-yp-compat-staff-v1-2-9b8d07f00af7@bootlin.com>
References: <20250224-mathieu-yp-compat-staff-v1-0-9b8d07f00af7@bootlin.com>
In-Reply-To: <20250224-mathieu-yp-compat-staff-v1-0-9b8d07f00af7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740394802; l=3425;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=J7ftUoWcSSm9FGkCFtS2oPMXafk4ecVFhI8FbkMSTxE=;
 b=GVXf3kyJgHgAFaFT1ictN4Vf0VOoEhGZecQv3dcTUcb42pNXuBcyTA7QJlcwrcdDPsa3TULKq
 TWVrXi5t3K0A4zaPp9hqsRapvh3FKTqgqf0FrQ24eLW0UavORlqZqqm
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgedtveetheejueefheeluedtudevffdutdelhffhgeefuefgueffveejveejffdunecuffhomhgrihhnpehushgvrhdrihhsnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqs
 ghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Feb 2025 11:00:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1122

Fixes [YOCTO #15738]

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 layerindex/forms.py | 7 ++++++-
 layerindex/views.py | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/layerindex/forms.py b/layerindex/forms.py
index 10acb8806d9e..360af402c2a4 100644
--- a/layerindex/forms.py
+++ b/layerindex/forms.py
@@ -24,7 +24,8 @@ import settings
 from layerindex.models import (Branch, ClassicRecipe,
                                LayerBranch, LayerItem, LayerMaintainer,
                                LayerNote, RecipeChange, RecipeChangeset,
-                               SecurityQuestion, UserProfile, PatchDisposition)
+                               SecurityQuestion, UserProfile, PatchDisposition,
+                               YPCompatibleVersion)
 
 
 class StyledForm(forms.Form):
@@ -77,6 +78,7 @@ class EditLayerForm(StyledModelForm):
     # Additional form fields
     vcs_subdir = forms.CharField(label='Repository subdirectory', max_length=60, required=False, help_text='Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)')
     actual_branch = forms.CharField(label='Actual branch', max_length=80, required=False, help_text='Name of the actual branch in the repository matching the core branch (e.g. the development branch is "master" by default)')
+    yp_compatible_version = forms.ModelChoiceField(label='Yocto Project Compatible version', queryset=YPCompatibleVersion.objects.all(), required=False)
     deps = forms.ModelMultipleChoiceField(label='Other layers this layer depends upon', queryset=LayerItem.objects.filter(comparison=False), required=False)
     captcha = CaptchaField(label='Verification', help_text='Please enter the letters displayed for verification purposes', error_messages={'invalid':'Incorrect entry, please try again'})
 
@@ -109,6 +111,9 @@ class EditLayerForm(StyledModelForm):
         self.fields = new_fields
         self.fields['vcs_subdir'].initial = layerbranch.vcs_subdir
         self.fields['actual_branch'].initial = layerbranch.actual_branch
+        self.fields['yp_compatible_version'].initial = layerbranch.yp_compatible_version
+        if not user.is_staff:
+            self.fields['yp_compatible_version'].widget.attrs['disabled'] = True
         self.was_saved = False
         self.allow_base_type = allow_base_type
 
diff --git a/layerindex/views.py b/layerindex/views.py
index 4df2a0921506..3cf91d2bf68d 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -204,6 +204,11 @@ def edit_layer_view(request, template_name, branch='master', slug=None):
                     reset_last_rev = True
                 layerbranch.save()
                 maintainerformset.save()
+                if (request.user.is_authenticated and request.user.is_staff):
+                    new_yp_compatible = form.cleaned_data['yp_compatible_version']
+                    if layerbranch.yp_compatible_version != new_yp_compatible:
+                        layerbranch.yp_compatible_version = new_yp_compatible
+                    layerbranch.save()
                 if slug:
                     new_deps = form.cleaned_data['deps']
                     existing_deps = [deprec.dependency for deprec in layerbranch.dependencies_set.all()]

-- 
2.39.5


