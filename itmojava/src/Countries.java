import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * Prefix lgd:<http://linkedgeodata.org/> Prefix lgdo:<http://linkedgeodata.org/ontology/>
Select ?country ?label { ?country a lgdo:Country. ?country rdfs:label ?label. filter( langMatches(lang(?label),'ru')).  }
 */
public class Countries
{

	public static void main(String[] args) throws FileNotFoundException, IOException
	{
		Map<String,String> idToLabel = new HashMap<>();
		Map<String,String> labelToLgd = new HashMap<>();

		try(TSVReader inIdLabel = new TSVReader(new File("input/idlabel.tsv")))
		{
			while(inIdLabel.hasNextTokens())
			{
				String[] tokens = inIdLabel.nextTokens();
				idToLabel.put(tokens[0], tokens[1]);
			}
		}

		try(TSVReader inLgdLabel = new TSVReader(new File("input/lgdlabel.tsv")))
		{
			while(inLgdLabel.hasNextTokens())
			{
			String[] tokens = inLgdLabel.nextTokens();
			labelToLgd.put(tokens[1], tokens[0]);
			}
		}

		Map<String,String> idToLgd = new HashMap<>();
		for(String id: idToLabel.keySet())
		{
			String label = idToLabel.get(id);
			if(labelToLgd.containsKey(label)) {idToLgd.put(id, labelToLgd.get(label));}
		}
		System.out.println(idToLabel.values());
		System.out.println(labelToLgd.keySet());

		System.out.println("found " +idToLgd.size()+ " matches ("+(idToLabel.size()-idToLgd.size())+" unmatched )");
		try(PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter("output/idlgd.tsv"))))
		{
			for(String id: idToLabel.keySet())
			{
				String lgd = idToLgd.get(id);
				if(lgd==null) out.println(id+'\t'+idToLabel.get(id));
			}
			for(String id: idToLgd.keySet())
			{
				out.println(id+'\t'+idToLgd.get(id));
			}
		}

	}

}