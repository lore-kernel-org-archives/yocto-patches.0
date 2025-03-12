Return-Path: <omri.sarig13@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB6BC28B30
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 11:08:18 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web11.34551.1741777694600195376
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Mar 2025 04:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Xc1EAc13;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: omri.sarig13@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5499614d3d2so5827069e87.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741777692; x=1742382492; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6T9DjeWdRd0bTx9J1JaKPjONNmJans7xTrq4trOY4aA=;
        b=Xc1EAc13/VASmuOFU+L/zJpaFmwwdBbjzytb0Y7XFJNXWc6Me4duCFLDDPGRCH7rzV
         TWlFfwOHD0/icf0/P1uYZLxxcJIZtAM40A13rLQuKY1oMZJF72fcn/jLVeh8nyur1GGc
         8E1lZMOZPH+Ux3Pjpm2ADDPbhyvxZuznQ/lt+So/VuFhp+Z9/MAZYBt/90vRvIxLRAvx
         6M+J0/TLDm2ij3W7DjhWIdJWzAV1vjFNmLzzjG9/TNwX5Br4/8LG7m73TiJYv8NXx+3a
         NCSuOIH2reMBnP2oBidTgAtQ8UL251GkbFilR2XI+JMspoIVdU0wBQEHhzUYMeW+2zAE
         3BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741777692; x=1742382492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6T9DjeWdRd0bTx9J1JaKPjONNmJans7xTrq4trOY4aA=;
        b=rOzLUGVF2cWGUyS0ywkv7vb8isvuN6T6K9RYqg6AiCAR5RU8xRg6D+ooEJaIO7kMI+
         /gDcYSfEuwCm87CLpfsEiIfLmyFH5qv1ntC39fi8Z+COJwf0TNgmX9fCAyym1CfdLl82
         jEnvj0d6ic848KGpBs/lKcwmpTD0Qo8EFFzyhrTMqzEcmQBQKv1DlilIin1KGjxxB5gA
         roktuzGJM5q6mjp0pBs0ogzw8cu8II6IvecrBZ8djvxGkJiwA8hiBzVv+f2ocMK6xmtb
         oTk3fcxxUAlAZOn3QRF5U/fF2lWUXsyLPxpXWI/R0Q8jWfvnGCbtL/mdrKwM/pIxxWkD
         0ZAw==
X-Forwarded-Encrypted: i=1; AJvYcCUj3owZOiJI9wD6+yblbpCy4yYGR9927sOgBReFlVnVFOAjKjh8Unoxc99tE0ethEusOxF4DgeBZ9zNEQlM@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxDuzvSd+Eg2pinIR1/mRK/Q/RMwSs//22kz/bEeyH7DS8hn/+O
	LPENDWexOmd2rPCH/217kX4gJzLmbSBjTdDeVRoOHpKcIEhiQ2f9
X-Gm-Gg: ASbGncspMiZpavbAF2xquvTGb0B8mJQoyoV7TnfYOFr+SfXudqwZ1VPJQSpmK6oni7G
	SeLnI8NB5NljU2yJw7qlNnjajVNyvp5OUILr6HAwkoq9Hq9olk+D1NPvcUtiQJiB8MRYm+c7CKJ
	B/qFI6HGNY6aNbEMjT8dlA1iHWs31p3uyTcRpK8+DrbFv1C/5ev6CRAfaJytWxZcAkMtlu1UC2I
	pye0YgO0GXVFwTnmZNge4BE6ta+55fSOqBzOQdsZfHgrflFU52n5zezZdqr38U/DGN59MJeg/r4
	hmcI0LOSu2NFzhbSCtquw0iABg/M+X6T50PUHDvnfBqWDSRUtA==
X-Google-Smtp-Source: AGHT+IGXVHZJNxe5e8gCyU75FIIgVMOhgb1yBJyiZ0m0K3a8/l3u45U9uA+hYqoIoK3+JOzONq9kEA==
X-Received: by 2002:a05:6512:ad1:b0:545:cc2:accd with SMTP id 2adb3069b0e04-54990e5ed55mr8400653e87.20.1741777692349;
        Wed, 12 Mar 2025 04:08:12 -0700 (PDT)
Received: from [172.16.6.176] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae591e1sm2092909e87.102.2025.03.12.04.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 04:08:11 -0700 (PDT)
Message-ID: <ff0fda36-0658-4e5f-83e6-917908884c4f@gmail.com>
Date: Wed, 12 Mar 2025 12:07:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH v2 3/3] oeqa/cases/tpm2: Add
 tpm2-pkcs11-tools sanity test
To: Mikko Rapeli <mikko.rapeli@linaro.org>,
 yocto-patches@lists.yoctoproject.org
References: <20250312103241.2526274-1-omri.sarig13@gmail.com>
 <20250312103241.2526274-4-omri.sarig13@gmail.com> <Z9FkFWK5JCRTELe9@nuoska>
Content-Language: en-US
From: Omri Sarig <omri.sarig13@gmail.com>
In-Reply-To: <Z9FkFWK5JCRTELe9@nuoska>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 11:08:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1195

On 3/12/25 11:38, Mikko Rapeli wrote:
> Hi,

Thanks for the fast reply!

>
> On Wed, Mar 12, 2025 at 11:32:41AM +0100, Omri Sarig via lists.yoctoproject.org wrote:
>> Add a very simple sanity test, which ensures that tpm2_ptool can run
>> without problems when the relevant package is available.
>>
>> This test case is available here to help prevent future errors, where
>> the tool is unable to run after installation, due to missing
>> dependencies for example.
>>
>> Contrary to other tests in the file, this test does not communicate with
>> the TPM module itself, it only ensures that the tool (tpm2_ptool) can be
>> loaded without any errors. Therefore, we don't need to depend on
>> anything other than having the package installed.
>>
>> Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
>> ---
>>   meta-tpm/lib/oeqa/runtime/cases/tpm2.py | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/meta-tpm/lib/oeqa/runtime/cases/tpm2.py b/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
>> index 8e90dc9..c2e6dfa 100644
>> --- a/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
>> +++ b/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
>> @@ -67,3 +67,8 @@ class Tpm2Test(OERuntimeTestCase):
>>       def test_tpm2_swtpm_reset(self):
>>            (status, output) = self.target.run('swtpm_ioctl -i --tcp :2322')
>>            self.assertEqual(status, 0, msg="swtpm reset failed: %s" % output)
>> +
>> +    @OEHasPackage(['tpm2-pkcs11-tools'])
>> +    def test_tpm2_pkcs11_tools(self):
>> +        (status, output) = self.target.run("tpm2_ptool --help")
>> +        self.assertEqual(status, 0, msg="Module cannot be run with error: %s" % output)
> Thanks! This good to start with. I think it's a separate question now if
> meta-tpm test images will include tpm2-pkcs11-tools and actually run
> this test.

I've looked into it now.
If I understand it correctly, and the image used for testing is 
security-tpm2-image 
(meta-security/meta-tpm/recipes-core/images/security-tpm2-image.bb), 
then the image already have tpm2-pkcs11-tools implicitly installed in it.

This is done as the image have the recipe of swtpm and the config of 
gnutls, which adds tpm2-pkcs11-tools to the runtime dependencies of swtpm.

I think we can do one of the following:

1. Update the image to explicitly install tpm2-pkcs11-tools (as a 
package in IMAGE_INSTALL).
2. Update the commit message to add the above explanation, so users will 
know that the tool is added to the image (and thus tested).
3. Leave the commits as-is.

What do you think makes the most sense?


With Kind Regards,
Omri


