package com.netflix.dynomitemanager.sidecore.aws;

import com.google.inject.Inject;
import com.netflix.dynomitemanager.defaultimpl.IConfiguration;
import com.netflix.dynomitemanager.identity.IMembership;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.yaml.snakeyaml.DumperOptions;
import org.yaml.snakeyaml.Yaml;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

public class YamlMembership implements IMembership {

	private static final Logger logger = LoggerFactory.getLogger(YamlMembership.class);
	private final IConfiguration config;
	private final List<String> members;

	private static List<String> getMembers(String datacenter, String rack, String membershipYaml) {
		logger.warn(String.format("Getting Members => DataCenter: %s, Rack: %s", datacenter, rack));
		List<String> members = new ArrayList<>();
		DumperOptions options = new DumperOptions();
		options.setDefaultFlowStyle(DumperOptions.FlowStyle.BLOCK);
		Yaml yaml = new Yaml(options);
		File yamlFile = new File(membershipYaml);
		Map<String, Object> datacenters;
		try {
			datacenters = (Map<String, Object>) yaml.load(new FileInputStream(yamlFile));

			Map<String, Object> racks = (Map<String, Object>) datacenters.get(datacenter);

			List<String> myRack = (List<String>) racks.get(rack);

			for(String line: myRack) {
				String[] tokens = line.split(" ");
				members.add(tokens[tokens.length - 1]);
			}

			StringBuilder sb = new StringBuilder();
			sb.append("Members (");
			sb.append(members.size());
			sb.append("): ");
			for (String member: members) {
				sb.append(member);
				sb.append(";");
			}
			logger.warn(sb.toString());
			return members;
		} catch (FileNotFoundException e) {
			logger.error("Unable to load membership yaml", e);
			return members;
		}
	}

	@Inject public YamlMembership(IConfiguration config) {
		this.config = config;
		this.members = getMembers(config.getDataCenter(), config.getRack(), config.getMembershipYaml());
	}

	@Override public List<String> getRacMembership() {
		return members;
	}

	@Override public List<String> getCrossAccountRacMembership() {
		throw new UnsupportedOperationException();
	}

	@Override public int getRacMembershipSize() {
		return getRacMembership().size();
	}

	@Override public int getCrossAccountRacMembershipSize() {
		throw new UnsupportedOperationException();
	}

	@Override public int getRacCount() {
		return config.getRacks().size();
	}

	@Override public void addACL(Collection<String> listIPs, int from, int to) {
	}

	@Override public void removeACL(Collection<String> listIPs, int from, int to) {
	}

	@Override public List<String> listACL(int from, int to) {
		return new ArrayList<>();
	}

	@Override public void expandRacMembership(int count) {
		throw new UnsupportedOperationException();
	}

}
