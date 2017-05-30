package com.netflix.dynomitemanager.sidecore.aws;

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.EnvironmentVariableCredentialsProvider;
import com.netflix.dynomitemanager.sidecore.ICredential;

public class EnvironmentVariableAwsCredential implements ICredential {
	private final AWSCredentialsProvider awsCredentialsProvider;

	public EnvironmentVariableAwsCredential() {
		this.awsCredentialsProvider = new EnvironmentVariableCredentialsProvider();
	}

	public AWSCredentialsProvider getAwsCredentialProvider() {
		return awsCredentialsProvider;
	}
}
